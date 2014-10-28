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
    value => $postgres_hardening::config_entry_logging_collector,
  }
  postgresql::server::config_entry { 'log_directory':
    value => $postgres_hardening::config_entry_log_directory,
  }
  postgresql::server::config_entry { 'log_connections':
    value => $postgres_hardening::config_entry_log_connections,
  }
  postgresql::server::config_entry { 'log_disconnections':
    value => $postgres_hardening::config_entry_log_disconnections,
  }
  postgresql::server::config_entry { 'log_duration':
    value => $postgres_hardening::config_entry_log_duration,
  }
  postgresql::server::config_entry { 'log_hostname':
    value => $postgres_hardening::config_entry_log_hostname,
  }
  postgresql::server::config_entry { 'log_line_prefix':
    value => $postgres_hardening::config_entry_log_line_prefix,
  }
  postgresql::server::config_entry { 'password_encryption':
    value => $postgres_hardening::config_entry_password_encryption,
  }
  postgresql::server::config_entry { 'ssl':
    value => $postgres_hardening::config_entry_ssl,
  }
  postgresql::server::config_entry { 'ssl_ciphers':
    value => $postgres_hardening::config_entry_ssl_ciphers,
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

    exec { 'purge link to /etc/ssl/certs/ssl-cert-snakeoil.pem':
      path    => '/bin',
      command => "rm /var/lib/postgresql/${postgresql::server::version}/main/server.crt",
      onlyif  => "ls -l /var/lib/postgresql/${postgresql::server::version}/main/server.crt |grep /etc/ssl/certs/ssl-cert-snakeoil.pem",
      require => Class['postgresql::server::install']
    }

    exec { 'purge link to /etc/ssl/private/ssl-cert-snakeoil.key':
      path    => '/bin',
      command => "rm /var/lib/postgresql/${postgresql::server::version}/main/server.key",
      onlyif  => "ls -l /var/lib/postgresql/${postgresql::server::version}/main/server.key |grep /etc/ssl/private/ssl-cert-snakeoil.key",
      require => Class['postgresql::server::install']
    }

  }
  # finally we need to make sure our options are written to the config file
  class{'postgres_hardening::puppetlabs_override': }

}
