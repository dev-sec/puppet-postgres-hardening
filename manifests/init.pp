# === Copyright
#
# Copyright 2014, Deutsche Telekom AG
# Licensed under the Apache License, Version 2.0 (the "License");
# http://www.apache.org/licenses/LICENSE-2.0
#

# == Class: postgres_hardening
#
# Configures overlay hardening
#
# === Parameters
#
# [*postgres_provider*]
#   The name of the provider you use to install Postgres.
#   Supported: `puppetlabs/postgresql`
#
# [*config_entry_logging_collector*]
#   This parameter enables the logging collector, which is a background process
#   that captures log messages sent to stderr and redirects them into log files.
#   See http://www.postgresql.org/docs/9.1/static/runtime-config-logging.html for details
#   Defaults to: `on`
#
# [*config_entry_log_directory*]
#   When logging_collector is enabled, this parameter determines the
#   directory in which log files will be created.
#   See http://www.postgresql.org/docs/9.1/static/runtime-config-logging.html for details
#   Defaults to: `pg_log`
#
# [*config_entry_log_connections*]
#   Causes each attempted connection to the server to be logged, as well as successful
#   completion of client authentication.
#   See http://www.postgresql.org/docs/9.1/static/runtime-config-logging.html for details
#   Defaults to: `on`
#
# [*config_entry_log_disconnections*]
#   This outputs a line in the server log similar to log_connections but at session
#   termination, and includes the duration of the session.
#   See http://www.postgresql.org/docs/9.1/static/runtime-config-logging.html for details
#   Defaults to: `on`
#
# [*config_entry_log_duration*]
#   Causes the duration of every completed statement to be logged
#   See http://www.postgresql.org/docs/9.1/static/runtime-config-logging.html for details
#   Defaults to: `on`
#
# [*config_entry_log_hostname*]
#   By default, connection log messages only show the IP address of the connecting host.
#   See http://www.postgresql.org/docs/9.1/static/runtime-config-logging.html for details
#   Defaults to: `on`
#
# [*config_entry_log_line_prefix*]
#   This is a printf-style string that is output at the beginning of each log line.
#   See http://www.postgresql.org/docs/9.1/static/runtime-config-logging.html for details
#   Defaults to: `%t %u %d %h`
#
# [*config_entry_password_encryption*]
#   When a password is specified in CREATE USER or ALTER ROLE without writing either
#   ENCRYPTED or UNENCRYPTED, this parameter determines whether the password is to be encrypted.
#   See http://www.postgresql.org/docs/9.1/static/runtime-config-connection.html for details
#   Defaults to: `on`
#
# [*config_entry_ssl*]
#   Enables SSL connections. Please read http://www.postgresql.org/docs/9.1/static/ssl-tcp.html
#   SSL certificates are out of scope of this module. This is why this setting defaults to `false`.
#   You have to provide ssl certificates *before* the startup of postgres, otherwise it will fail to start.
#   See http://www.postgresql.org/docs/9.1/static/runtime-config-connection.html for details
#   Defaults to: `off`
#


class postgres_hardening(

  $provider = 'none',

  $config_entry_logging_collector = 'on',
  $config_entry_log_directory = 'pg_log',
  $config_entry_log_connections = 'on',
  $config_entry_log_disconnections = 'on',
  $config_entry_log_duration = 'on',
  $config_entry_log_hostname = 'on',
  $config_entry_log_line_prefix = '%t %u %d %h',
  $config_entry_password_encryption = 'on',
  $config_entry_ssl = 'off',
  $config_entry_ssl_ciphers = 'ALL:!ADH:!LOW:!EXP:!MD5:@STRENGTH',

) {
  case $provider {
    'puppetlabs/postgresql': {
      class{'postgres_hardening::puppetlabs': }
    }
    'none': {
      fail('You haven\'t configured a Postgres provider for hardening.')
    }
    default: {
      fail('Unrecognized/Unsupported Postgres provider for hardening.')
    }
  }
}
