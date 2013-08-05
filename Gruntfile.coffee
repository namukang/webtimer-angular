module.exports = (grunt) ->
  # load all grunt tasks
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  appConfig =
    app: "app"
    dist: "dist"

  grunt.initConfig
    webtimer: appConfig

    watch:
      coffee:
        files: ["<%= webtimer.app %>/{,*/}*.coffee"]
        tasks: ["coffee:dist"]
      coffeeTest:
        files: ["test/spec/{,*/}*.coffee"]
        tasks: ["coffee:test"]
      copy:
        files: [
          "<%= webtimer.app %>/manifest.json"
          "<%= webtimer.app %>/{,*/}*.html"
        ]
        tasks: ["copy:dist"]

    clean:
      dist:
        files: [
          dot: true
          src: [
            "<%= webtimer.dist %>/*"
          ]
        ]

    coffee:
      dist:
        files: [
          expand: true
          cwd: "<%= webtimer.app %>"
          src: "{,*/}*.coffee"
          dest: "<%= webtimer.dist %>"
          ext: ".js"
        ]
      test:
        files: [
          expand: true
          cwd: "test/spec"
          src: "{,*/}*.coffee"
          dest: "<%= webtimer.dist %>/spec"
          ext: ".js"
        ]

    copy:
      dist:
        files: [
          expand: true
          cwd: "<%= webtimer.app %>"
          dest: "<%= webtimer.dist %>"
          src: [
            "manifest.json"
            "bower_components/**"
            "!bower_components/jasmine/**"
            "images/*"
            "oauth2/**"
            "{,*/}*.html"
          ]
        ]
      test:
        files: [
          expand: true
          cwd: "<%= webtimer.app %>"
          dest: "<%= webtimer.dist %>"
          src: [
            "bower_components/jasmine/lib/jasmine-core/*"
          ]
        ,
          expand: true
          cwd: "test"
          dest: "<%= webtimer.dist %>"
          src: [
            "spec/runner.html"
          ]
        ]

  grunt.registerTask "default", [
    "clean"
    "coffee"
    "copy"
  ]

  grunt.registerTask "build", [
    "clean"
    "coffee:dist"
    "copy:dist"
  ]
