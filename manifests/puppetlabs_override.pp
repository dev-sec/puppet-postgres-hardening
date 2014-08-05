# === Copyright
#
# Copyright 2014, Deutsche Telekom AG
# Licensed under the Apache License, Version 2.0 (the "License");
# http://www.apache.org/licenses/LICENSE-2.0
#

# == Class: postgres_hardening::puppetlabs_override
#
# Overlay provider for puppetlabs/postgresql
#
# === Parameters
#
# none
#
class postgres_hardening::puppetlabs_override inherits ::postgresql::server::config {

    Postgresql::Server::Pg_hba_rule['local access to database with same name']{
      auth_method => 'md5',
  }
}
