require 'devise'
require 'devise_ldap_authenticatable'

require 'devise_ldap_authenticatable_sync/engine'
require 'devise_ldap_authenticatable_sync/model'
require 'devise_ldap_authenticatable_sync/ldap_adapter'

module Devise
  mattr_accessor :ldap_sync_registrations
  @@ldap_sync_registrations = true
end
