require 'devise'
require 'devise_ldap_authenticatable'

require 'devise_ldap_authenticatable_sync/engine'
require 'devise_ldap_authenticatable_sync/model'
require 'devise_ldap_authenticatable_sync/ldap_adapter'

module Devise
  mattr_accessor :ldap_sync_registrations
  @@ldap_sync_registrations = true

  mattr_accessor :ldap_sync_object_classes
  @@ldap_sync_object_classes = ["top","simplesecurityobject","inetorgperson"]

  mattr_accessor :ldap_sync_root_entry
  @@ldap_sync_object_classes = "users"

  mattr_accessor :ldap_sync_default_sn
  @@ldap_sync_object_classes = "Some User"
end
