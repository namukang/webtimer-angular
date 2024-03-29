module.exports = (config) ->
  config.set
    # base path, that will be used to resolve files and exclude
    basePath: ''

    frameworks: ['jasmine']

    # list of files / patterns to load in the browser
    files: [
      'app/bower_components/angular/angular.js'
      'app/bower_components/angular-mocks/angular-mocks.js'
      'app/popup/popup.coffee'
      'app/**/*.coffee'
      'test/spec/**/*.coffee'
    ]

    # list of files to exclude
    exclude: [
      'app/background/*.coffee'
      'test/spec/background/*.coffee'
    ]

    # test results reporter to use
    # possible values: dots || progress
    reporters: ['progress']

    # web server port
    port: 8080

    # enable / disable colors in the output (reporters and logs)
    colors: true

    # level of logging
    # possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_INFO

    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true

    # Start these browsers, currently available:
    # - Chrome
    # - ChromeCanary
    # - Firefox
    # - Opera
    # - Safari (only Mac)
    # - PhantomJS
    # - IE (only Windows)
    browsers: ['PhantomJS']

    # If browser does not capture in given timeout [ms], kill it
    captureTimeout: 5000

    # Continuous Integration mode
    # if true, it capture browsers, run tests and exit
    singleRun: false
