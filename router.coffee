http = require 'http'

routes = {}

setRoute = (pathPattern, targetHost, targetPort) ->
	routes[pathPattern] = { host: targetHost, port: targetPort}

route = (httpResponse, pathname, query) ->
	for pattern, target of routes
		if new RegExp(pattern).test pathname
			options = { host: target['host'], port: target['port'], path: pathname }
			processResponse = (response) ->
				console.log "Received response with status #{response.statusCode}"
				httpResponse.writeHead response.statusCode, {'Content-Type': 'text/plain'}
				response.pipe httpResponse
			http.request(options, processResponse).end()
		else
			httpResponse.writeHead 404, {'Content-Type': 'text/plain'}
			httpResponse.write 'No route'
			httpResponse.end()

exports.route = route
exports.setRoute = setRoute
