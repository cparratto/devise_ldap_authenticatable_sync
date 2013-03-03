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

              attr = {  :cn => @login,
                        :ou =>::Devise.ldap_sync_root_entry,
                        :objectclass => ::Devise.ldap_sync_object_classes,
                        :mail => @login,
                        :sn => ::Devise.ldap_sync_default_sn,
                        :userpassword => Net::LDAP::Password.generate(:sha, @password)
              }

              unless privileged_ldap.add(:dn => "cn=#{@login}, cn=#{::Devise.ldap_sync_root_entry}, #{privileged_ldap.base}", :attributes => attr)
                raise ::DeviseLdapAuthenticatable::LdapException, "Unable to add user LDAP Error: #{privileged_ldap.get_operation_result} \n Attr Dump: #{attr}"
              end
            end
          end
        end
      end
    end
  end
end