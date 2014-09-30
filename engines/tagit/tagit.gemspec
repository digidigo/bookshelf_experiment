$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tagit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tagit"
  s.version     = Tagit::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Tagit."
  s.description = "TODO: Description of Tagit."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.2"
  s.add_dependency 'acts-as-taggable-on'

  s.add_development_dependency "sqlite3"
end
