# postgres_hardening (Puppet module)

[![Puppet Forge](https://img.shields.io/puppetforge/dt/hardening/postgres_hardening.svg)][1]
[![Build Status](http://img.shields.io/travis/hardening-io/puppet-postgres-hardening.svg)][2]
[![Gitter Chat](https://badges.gitter.im/Join%20Chat.svg)][3]

## Description

This module provides hardening configuration for Postgres.

## Requirements

* Puppet

## Parameters

* `config_entry_logging_collector = 'on'`
   This parameter enables the logging collector, which is a background process 
   that captures log messages sent to stderr and redirects them into log files. 
   See http://www.postgresql.org/docs/9.1/static/runtime-config-logging.html for details
   Defaults to: `on`

* `config_entry_log_directory = 'pg_log'`
   When logging_collector is enabled, this parameter determines the 
   directory in which log files will be created. 
   See http://www.postgresql.org/docs/9.1/static/runtime-config-logging.html for details
   Defaults to: `pg_log`

* `config_entry_log_connections = 'on'`
   Causes each attempted connection to the server to be logged, as well as successful 
   completion of client authentication. 
   See http://www.postgresql.org/docs/9.1/static/runtime-config-logging.html for details
   Defaults to: `on`

* `config_entry_log_disconnections = 'on'`
   This outputs a line in the server log similar to log_connections but at session 
   termination, and includes the duration of the session. 
   See http://www.postgresql.org/docs/9.1/static/runtime-config-logging.html for details
   Defaults to: `on`

* `config_entry_log_duration = 'on'`
   Causes the duration of every completed statement to be logged 
   See http://www.postgresql.org/docs/9.1/static/runtime-config-logging.html for details
   Defaults to: `on`

* `config_entry_log_hostname = 'on'`
   By default, connection log messages only show the IP address of the connecting host. 
   See http://www.postgresql.org/docs/9.1/static/runtime-config-logging.html for details
   Defaults to: `on`

* `config_entry_log_line_prefix = '%t %u %d %h'`
   This is a printf-style string that is output at the beginning of each log line. 
   See http://www.postgresql.org/docs/9.1/static/runtime-config-logging.html for details
   Defaults to: `%t %u %d %h`

* `config_entry_password_encryption = 'on'`
   When a password is specified in CREATE USER or ALTER ROLE without writing either 
   ENCRYPTED or UNENCRYPTED, this parameter determines whether the password is to be encrypted. 
   See http://www.postgresql.org/docs/9.1/static/runtime-config-connection.html for details
   Defaults to: `on`

* `config_entry_ssl = 'off'`
   Enables SSL connections. Please read http://www.postgresql.org/docs/9.1/static/ssl-tcp.html 
   SSL certificates are out of scope of this module. This is why this setting defaults to `off`.
   You have to provide ssl certificates *before* the startup of postgres, otherwise it will fail to start.  
   See http://www.postgresql.org/docs/9.1/static/runtime-config-connection.html for details
   Defaults to: `off`

## Usage

```
class { '::postgresql::server':
  postgres_password          => 'iloverandompasswordsbutthiswilldo',
}

class { '::postgres_hardening':
  provider => 'puppetlabs/postgresql',
}
```

### Enable SSL

Please read http://www.postgresql.org/docs/9.1/static/ssl-tcp.html first. 

This module will delete the links from `/var/lib/postgresql/${postgresql::server::version}/main/server.crt` to `/etc/ssl/certs/ssl-cert-snakeoil.pem` and `/var/lib/postgresql/${postgresql::server::version}/main/server.key` to `/etc/ssl/private/ssl-cert-snakeoil.key` on Debian systems. This certificates are self-signed (see http://en.wikipedia.org/wiki/Snake_oil_%28cryptography%29) and therefore not trusted. You have to provide your own trusted certificates for SSL.

```
class { '::postgresql::server':
  postgres_password          => 'iloverandompasswordsbutthiswilldo',
}

class { '::postgres_hardening':
  provider => 'puppetlabs/postgresql',
  config_entry_ssl => 'on'
}
```

## Contributors + Kudos

* Edmund Haselwanter [ehaselwanter](https://github.com/ehaselwanter)

## License and Author

* Author:: Deutsche Telekom AG

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[1]: https://forge.puppetlabs.com/hardening/postgres_hardening
[2]: http://travis-ci.org/hardening-io/puppet-postgres-hardening
[3]: https://gitter.im/hardening-io/general
