$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devise_ldap_authenticatable_sync/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "devise_ldap_authenticatable_sync"
  s.version     = DeviseLdapAuthenticatableSync::VERSION
  s.authors     = ["Christopher Parratto"]
  s.email       = ["cparratto@gmail.com"]
  s.homepage    = "http://www.github.com/"
  s.summary     = "DeviseLdapAuthenticatableSync is a small extension to the DeviseLdapAuthenticatable."
  s.description = "DeviseLdapAuthenticatableSync syncs your devise user records with ldap after registration."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.11"
  s.add_dependency "devise"
  s.add_dependency "devise_ldap_authenticatable"


  s.add_development_dependency "sqlite3"
end
