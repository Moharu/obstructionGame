module.exports = (grunt) ->

    config =
        pkg: grunt.file.readJSON 'package.json'
        mochaTest:
            progress:
                options:
                    reporter: 'progress'
                    require: ['coffee-script/register', 'blanket']
                    captureFile: 'mochaTest.log'
                    quiet: false,
                    clearRequireCache: false
                src: ['test/**/*.coffee']
            spec:
                options:
                    reporter: 'spec'
                    require: ['coffee-script/register', 'blanket']
                    captureFile: 'mochaTest.log'
                    quiet: false,
                    clearRequireCache: false
                src: ['test/**/*.coffee']
        watch:
            src:
                files: ['**/*.coffee']
                tasks: ['test']
            gruntfile:
                files: ['Gruntfile.coffee']

    grunt.initConfig config

    require('load-grunt-tasks')(grunt)

    grunt.registerTask 'default', 'Watch', ->
        grunt.task.run 'watch'
    grunt.registerTask 'test', ['mochaTest:progress']
