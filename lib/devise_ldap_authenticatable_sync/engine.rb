module DeviseLdapAuthenticatableSync
  class Engine < Rails::Engine
    initializer 'devise_ldap_authenticatable_sync.init', :after => :disable_dependency_loading do |app|
      ::Devise::LdapAdapter.send(:extend, ::Devise::LdapAdapter::Sync) unless
          ::Devise::LdapAdapter.include?(::Devise::LdapAdapter::Sync)
      ::Devise::LdapAdapter::LdapConnect.send(:include, ::Devise::LdapAdapter::Sync::LdapConnect) unless
          ::Devise::LdapAdapter::LdapConnect.include?(::Devise::LdapAdapter::Sync::LdapConnect)
    end
  end
end