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

            privileged_ldap = nil

            if ::Devise.ldap_use_admin_to_bind
              privileged_ldap = ::Devise::LdapAdapter::LdapConnect.admin
            else
              authenticate!
              privileged_ldap = self.ldap
            end

            if privileged_ldap.nil?
              raise ::DeviseLdapAuthenticatable::LdapException, "Cannot connect to admin LDAP user"
            elsif ::Devise.ldap_use_admin_to_bind
              #TODO: these attributes should be configurable

              ::DeviseLdapAuthenticatable::Logger.send("User: #{dn}")

              attr = {
                  :cn => @login,
                  :objectclass => ["simpleSecurityObject", "organizationalRole"],
                  :sn => "Some User",
              }

              #TODO: make first cn customizable
              privileged_ldap.add(:dn => "cn=customers, #{@ldap.base}", :attributes => attr)
            end
          end
        end
      end
    end
  end
end