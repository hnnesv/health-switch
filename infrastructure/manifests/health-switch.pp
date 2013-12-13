# Puppet manifest
#
# Required modules:
# willdurand/nodejs
# puppetlabs/mongodb
#
# puppet module install can be used when not using vagrant
#

# defaults for Exec
Exec {
	path => ["/bin", "/sbin", "/usr/bin", "/usr/sbin", "/usr/local/bin", "/usr/local/sbin"],
	user => "root",
}

class { "mongodb":
	init => "upstart",
}

class { "nodejs":
	version => "stable",
}

exec { "npm-install":
	cwd => "/healthswitch",
	command => "npm install",
	require => Class["nodejs"],
}

exec { "coffeescript":
	command => "npm install -g coffee-script",
	require => Class["nodejs"],
}
