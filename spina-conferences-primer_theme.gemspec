# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'spina/conferences/primer_theme/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name = 'spina-conferences-primer_theme'
  spec.version = Spina::Conferences::PrimerTheme::VERSION
  spec.authors = ['Justin Malčić']
  spec.email = ['j.malcic@me.com']
  spec.homepage = 'https://jmalcic.github.io/projects/spina-conferences/primer-theme'
  spec.summary = 'Spina::Admin::Conferences frontend theme.'
  spec.description = 'Frontend for Spina::Admin::Conferences plugin, based on Primer.'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'babel-transpiler', '~> 0.7'
  spec.add_dependency 'icalendar', '~> 2.5'
  spec.add_dependency 'image_processing', '~> 1.9'
  spec.add_dependency 'primer_view_components', '0.0.10'
  spec.add_dependency 'rails', '~> 6.0.2'
  spec.add_dependency 'spina', '~> 1.1'
  spec.add_dependency 'spina-admin-conferences', '~> 1.3.3'

  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'dotenv-rails'
  spec.add_development_dependency 'minitest-rails'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'puma'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rails'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'selenium-webdriver'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'web-console'
  spec.add_development_dependency 'webdrivers'
end
