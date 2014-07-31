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
class postgres_hardening(
  $provider = 'none',
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
