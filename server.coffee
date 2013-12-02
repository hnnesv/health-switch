http = require 'http'
url = require 'url'
router = require './router'
config = require './defaultchannel-config'

start = (port) ->
	http.createServer((request, response) ->
		parse = url.parse request.url, yes
		path = parse.pathname
		query = parse.query
		console.log 'Received request for ' + path

		router.route response, path, query
	).listen port
	console.log "Server up and running on port #{port}"

config.loadPatternsFromConfig router
start(5001)
