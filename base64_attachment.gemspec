$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "base64_attachment/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "base64_attachment"
  s.version     = Base64Attachment::VERSION
  s.authors     = ["Rafael Nowrotek"]
  s.email       = ["mail@benignware.com"]
  s.homepage    = "https://github.com/benignware/base64_attachment"
  s.summary     = "Upload base64-encoded file attachments to a rails rest service."
  s.description = "This gem allows you to define `file`-attributes on an active record class which can receive base64-encoded strings which comes in handy for json rest clients posting images to a rails application. Simply post your base64-encoded string using the `_base64`-suffix on the attribute name."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.5"
  s.add_dependency "mime-magic", "~> 0.2.0"

  s.add_development_dependency "sqlite3"
end
