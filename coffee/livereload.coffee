class Server
  config: 
    aliases: [
      jade: 'html',
      less: 'css',
      sass: 'css',
      scss: 'css',
      styl: 'css',
      coffee: 'js'
    ]
    applyJsLive: false
    applyCssLive: true
    debug: true
    delay: 0
    exclusions: [
      '.git/',
      '.svn/',
      '.hg/'
    ]
    extensions: [
      'html', 'jade',
      'css', 'less', 'sass', 'scss', 'styl',
      'js', 'coffee',
      'png', 'gif', 'jpg',
      'php', 'php5', 'phtml',
      'py',
      'rb', 'erb'
    ]
    port: 35729

  sockets: []

  constructor: (config) ->
    @config[attr] = value for value, attr in config

  debug: (string) ->
    if @config.debug
      console.log str