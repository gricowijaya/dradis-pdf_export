# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dradis/pdf_export/version', __FILE__)
version = Dradis::PdfExport::VERSION.to_s

Gem::Specification.new do |gem|
  gem.platform = Gem::Platform::RUBY
  gem.name = "dradis-pdf_export"
  gem.version = version
  gem.required_ruby_version = '>= 1.9.3'
  gem.license = 'GPL-2'

  gem.authors = ['Daniel Martin']
  gem.email = ["<etd@nomejortu.com>"]
  gem.description = %q{Export to PDF plugin for the Dradis Framework}
  gem.summary = %q{Dradis PDF export plugin}
  gem.homepage = 'http://dradisframework.org'

  gem.files = `git ls-files`.split($\)
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  # gem.add_dependency 'dradis_core', version
  gem.add_dependency 'prawn', '~> 0.15.0'

  gem.add_development_dependency 'capybara', '~> 1.1.3'
  gem.add_development_dependency 'database_cleaner'
  gem.add_development_dependency 'factory_girl_rails'
  gem.add_development_dependency 'rspec-rails', '~> 2.11.0'
  gem.add_development_dependency 'sqlite3'
end