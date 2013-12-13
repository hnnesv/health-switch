mongoose = require 'mongoose'
fs = require 'fs'

defaultChannelSchema = mongoose.Schema({
"channels": [
	{
		"urlPattern": String,
		"host": String,
		"port": Number,
		"allowUnsecured": String
	}
]
})

mongoose.connect 'mongodb://localhost/healthswitch'
DefaultChannelModel = mongoose.model "defaultChannel", defaultChannelSchema

# Load default mapping
loadDefaultMapping = (file) ->
	mappingFile = JSON.parse fs.readFileSync file
	defaultChannel = new DefaultChannelModel { "channels": mappingFile }
	defaultChannel.save (err) ->
		if err
			console.log "oh no!"
			console.log err
		else
			console.log "Default channel mapping loaded from #{file}"

# Read default-channel config from MongoDB
loadPatternsFromConfig = (router) ->
	DefaultChannelModel.findOne (err, defaultChannel) ->
		if err
			console.log "oh no!"
			console.log err
		else
			for channel in defaultChannel.channels
				if channel.allowUnsecured is 'true'
					router.setRoute channel.urlPattern, channel.host, channel.port
			console.log "Router setup with default channel mapping"

exports.loadDefaultMapping = loadDefaultMapping
exports.loadPatternsFromConfig = loadPatternsFromConfig
