module Devise
  module Models
    module LdapAuthenticatableSync
      extend ActiveSupport::Concern

      included do
        before_create :create_ldap_reference if ::Devise.ldap_sync_registrations
      end

      def create_ldap_reference
        Devise::LdapAdapter.add_credentials(login_with, @password)
      end

      module ClassMethods
      end
    end
  end
end

Devise.add_module(:ldap_authenticatable_sync,
                  :route => :session,
                  :strategy => false,
                  :controller => :sessions,
                  :model => 'devise_ldap_authenticatable_sync/model')