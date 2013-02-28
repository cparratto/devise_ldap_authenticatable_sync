module Devise
  module LdapAdapter
    module Sync
      def add_credentials(login, password_plaintext)
        options = {:login => login,
                   :password => password_plaintext,
                   :ldap_auth_username_builder => ::Devise.ldap_auth_username_builder,
                   :admin => ::Devise.ldap_use_admin_to_bind}
        resource = ::Devise::LdapAdapter::LdapConnect.new(options)
        resource.create_ldap_user!
      end

      module LdapConnect
        def create_ldap_user!
          unless valid_login?
            ::DeviseLdapAuthenticatable::Logger.send("LDAP adding new user: #{@attribute}=#{@login}")
          end
        end
      end
    end
  end
end