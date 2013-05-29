fs                = require 'fs'
path              = require 'path'
LRWebSocketServer = require 'livereload-server'

module.exports = class ZweLivereload
	config:
		aliases: {
			jade: 'html'
			less: 'css'
			sass: 'css'
			scss: 'css'
			styl: 'css'
			coffee: 'js'
		}
		applyJsLive: false
		applyCssLive: true
		delay: 0
		exclusions: [
			'.git/'
			'.svn/'
			'.hg/'
		]
		extensions: [
			'html', 'jade'
			'css', 'less', 'sass', 'scss', 'styl'
			'js', 'coffee'
			'png', 'gif', 'jpg', 'jpeg'
			'php', 'php5', 'phtml'
			'py'
			'rb', 'erb'
		]
		port: 35729
		protocols:  {
			monitoring: 7
			conncheck: 1
			saving: 1
		}

	debug: true
	server: null

	constructor: (config) ->
		if config
			@config[attr] = value for value, attr in config

		@server = new LRWebSocketServer {
			id: 'zwe-livereload'
			name: 'zwe'
			version: '0.0.1'
			protocols: @config.protocols
		}

		@server.on 'connected',     @onConnected.bind @
		@server.on 'disconnected',  @onDisconnected.bind @
		@server.on 'command',       @onCommand.bind @
		@server.on 'error',         @onError.bind @
		@server.on 'livereload.js', @onLivereloadJs.bind @
		@server.on 'httprequest',   @onHttpRequest.bind @

	onConnected: (connection) ->
		if @debug
			console.log 'Client connected (%s)', connection.id

	onDisconnected: (connection) ->
		if @debug
			console.log 'Client disconnected (%s)', connection.id

	onCommand: (connection, message) ->
		if @debug
			console.log 'Received command %s: %j', message.command, message

	onError: (error, connection) ->
		if @debug
			console.log 'Error (%s): %s', connection.id, error.message

	onLivereloadJs: (request, response) ->
		if @debug
			console.log 'Serving livereload.js'

		fs.readFile path.join(__dirname, '../resource/livereload.js'), 'utf8', (error, data) =>
			if error
				console.error error

			response.writeHead 200, {
				'Content-Length': data.length
				'Content-Type': 'text/javascript'
			}
			response.end data

	onHttpRequest: (url, request, response) ->
		if @debug
			console.log url

		response.writeHead 404
		response.end()

	listen: (callback)->
		if !callback
			callback = (error) =>
				if error
					console.error 'Listening failed: %s', error.message
					return

				if @debug
					console.log 'Listening on port %d', @server.port
		@server.listen callback

new ZweLivereload().listen()