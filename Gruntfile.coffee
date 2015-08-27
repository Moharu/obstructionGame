module.exports = (grunt) ->

    config =
        pkg: grunt.file.readJSON 'package.json'
        mochaTest:
            progress:
                options:
                    reporter: 'progress'
                    require: ['coffee-script/register']
                    quiet: false,
                src: ['test/**/*.coffee']
            spec:
                options:
                    reporter: 'spec'
                    require: ['coffee-script/register']
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

    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-mocha-test'

    grunt.registerTask 'default', 'Watch', ->
        grunt.task.run 'watch'
    grunt.registerTask 'test', ['mochaTest:progress']
