gulp = require 'gulp'
runSequence = require 'run-sequence'
plugins = require('gulp-load-plugins')()
bowerFiles = require 'main-bower-files'
broswerify = require 'browserify'

gulp.task 'clean', ->
  gulp.src(['dest'], read: false)
  .pipe(plugins.clean())

gulp.task 'build', ->
  runSequence ['build:js:client', 'build:js:shared', 'build:js:server'], 'build:views'

gulp.task 'nodemon', ->
  plugins.nodemon(script : 'app.js')

gulp.task 'watch', ->
  gulp.watch 'src/server/**/*', ->
    runSequence 'build:js:server'
  gulp.watch 'src/client/**/*', ->
    runSequence 'build:js:client', 'build:views'
  gulp.watch 'src/shared/**/*', ->
    runSequence 'build:js:shared', 'build:views'
  gulp.watch 'src/views/**/*', ->
    runSequence 'build:views'

gulp.task 'run', ->
  runSequence 'clean', 'build', 'watch', 'nodemon'

gulp.task 'build:js:client', ->
  gulp.src('**/*.coffee', {cwd : 'src/client', cwdbase : true})
  .pipe(plugins.coffee())
  .pipe(gulp.dest 'dest/client')

gulp.task 'build:js:shared', ->
  gulp.src('**/*.coffee', {cwd : 'src/shared', cwdbase : true})
  .pipe(plugins.coffee())
  .pipe(gulp.dest 'dest/shared')

gulp.task 'build:js:server', ->
  gulp.src('**/*.coffee', {cwd : 'src/server', cwdbase : true})
  .pipe(plugins.coffee())
  .pipe(gulp.dest 'dest/server')

gulp.task 'build:views', ['build:js:client', 'build:js:shared'], ->
  bower  = gulp.src(bowerFiles(), {read: false})
  shared = gulp.src('**/*.{css,js}', {cwd: 'dest/shared/', read : false})
  client = gulp.src('**/*.{css,js}', {cwd: 'dest/client/', read : false})

  gulp.src('**/*.jade', {cwd : 'src/views', cwdbase : true})
  .pipe(plugins.inject(bower, {
        name: 'bower'
        ignorePath : 'bower_components'
      }))
  .pipe(plugins.inject(shared, {
        name: 'shared'
        addRootSlash : true
      }))
  .pipe(plugins.inject(client, {
        name: 'client'
        addRootSlash : true
      }))
  .pipe(gulp.dest 'dest/views')
