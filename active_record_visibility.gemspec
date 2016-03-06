$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_record_visibility/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_record_visibility"
  s.version     = ActiveRecordVisibility::VERSION
  s.authors     = ["Abdul Barek"]
  s.email       = ["barek2k2@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ActiveRecordVisibility."
  s.description = "TODO: Description of ActiveRecordVisibility."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"

  s.add_development_dependency "sqlite3"
end
