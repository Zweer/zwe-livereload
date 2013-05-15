LRProtocol = require 'livereload-protocol'

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

  parser: null
  protocols: 
    monitoring: [LRProtocol.protocols.MONITORING_7]
    conncheck:  [LRProtocol.protocols.CONN_CHECK_1]
    saving:     [LRProtocol.protocols.SAVING_1]
  server: null
  sockets: []

  constructor: (config) ->
    if config
      @config[attr] = value for value, attr in config

    @parser = new LRProtocol 'server', @protocols

  listen: ->
    @debug 'LiveReload is waiting for browser to connect'

    if @config.server
      @config.server.listen @config.port
      @server = ws.attach @config.server
    else
      @server = ws.listen @config.port

    @server.on 'connection', @onConnection.bind @
    @server.on 'close',      @onClose.bind @

  onConnection: (socket) ->
    @debug 'Browser connected'


    
  onClose: (socket) ->
    @debug 'Browser disconnected'

  debug: (string) ->
    if @config.debug
      console.log string

new Server().listen()