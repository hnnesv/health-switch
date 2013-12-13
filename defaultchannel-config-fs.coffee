fs = require 'fs'

loadPatternsFromConfig = (router) ->
	defaultChannelConfig = JSON.parse fs.readFileSync 'defaultchannel-mapping.json'
	for channel in defaultChannelConfig
		if channel.allowUnsecured is 'true'
 			router.setRoute channel.urlPattern, channel.host, channel.port

exports.loadPatternsFromConfig = loadPatternsFromConfig
