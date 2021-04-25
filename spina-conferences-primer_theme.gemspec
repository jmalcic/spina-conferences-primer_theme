# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'spina/conferences/primer_theme/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec| # rubocop:disable Metrics/BlockLength
  spec.name = 'spina-conferences-primer_theme'
  spec.version = Spina::Conferences::PrimerTheme::VERSION
  spec.required_ruby_version = '~> 2.7'
  spec.authors = ['Justin Malčić']
  spec.email = ['j.malcic@me.com']
  spec.homepage = 'https://jmalcic.github.io/projects/spina-conferences/primer-theme'
  spec.summary = 'Spina::Admin::Conferences frontend theme.'
  spec.description = 'Frontend for Spina::Admin::Conferences plugin, based on Primer.'
  spec.license = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'babel-transpiler', '~> 0.7'
  spec.add_dependency 'icalendar', '~> 2.5'
  spec.add_dependency 'image_processing', '~> 1.9'
  spec.add_dependency 'primer_view_components', '0.0.37'
  spec.add_dependency 'rails', '~> 6.0'
  spec.add_dependency 'spina', '~> 2.0'
  spec.add_dependency 'spina-admin-conferences', '~> 2.1.0'
  spec.add_dependency 'spina-admin-journal', '~> 0.2'

  spec.add_development_dependency 'capybara', '~> 3.33'
  spec.add_development_dependency 'dotenv-rails', '~> 2.7'
  spec.add_development_dependency 'minitest-reporters', '~> 1.4'
  spec.add_development_dependency 'puma', '~> 5.0'
  spec.add_development_dependency 'rubocop', '~> 1.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.8'
  spec.add_development_dependency 'rubocop-rails', '~> 2.8'
  spec.add_development_dependency 'selenium-webdriver', '~> 3.142'
  spec.add_development_dependency 'simplecov', '~> 0.19'
  spec.add_development_dependency 'simplecov-lcov', '~> 0.8'
  spec.add_development_dependency 'web-console', '~> 4.0'
  spec.add_development_dependency 'webdrivers', '~> 4.4'
end
