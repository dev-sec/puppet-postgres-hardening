# === Copyright
#
# Copyright 2014, Deutsche Telekom AG
# Licensed under the Apache License, Version 2.0 (the "License");
# http://www.apache.org/licenses/LICENSE-2.0
#

# == Class: postgres_hardening::puppetlabs
#
# Overlay provider for puppetlabs/postgresql
#
# === Parameters
#
# none
#
class postgres_hardening::puppetlabs(
) {
  # hardening options
  postgresql::server::config_entry { 'logging_collector':
    value => 'on',
  }
  postgresql::server::config_entry { 'log_directory':
    value => 'pg_log',
  }
  postgresql::server::config_entry { 'log_connections':
    value => 'on',
  }
  postgresql::server::config_entry { 'log_disconnections':
    value => 'on',
  }
  postgresql::server::config_entry { 'log_duration':
    value => 'on',
  }
  postgresql::server::config_entry { 'log_hostname':
    value => 'on',
  }
  postgresql::server::config_entry { 'log_line_prefix':
    value => '%t %u %d %h',
  }
  postgresql::server::config_entry { 'password_encryption':
    value => 'on',
  }
  postgresql::server::config_entry { 'ssl':
    value => 'on',
  }
  postgresql::server::config_entry { 'ssl_ciphers':
    value => 'ALL:!ADH:!LOW:!EXP:!MD5:@STRENGTH',
  }

  if ($::osfamily == 'Debian') {

    file { '/var/lib/postgresql':
      ensure  => 'directory',
      mode    => '0700',
      require => Class['postgresql::server::install'],
    }

    file { "/var/lib/postgresql/${postgresql::server::version}":
      ensure  => 'directory',
      mode    => '0700',
      require => Class['postgresql::server::install'],
    }
  }
  # finally we need to make sure our options are written to the config file
  class{'postgres_hardening::puppetlabs_override': }

}
