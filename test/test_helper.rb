# frozen_string_literal: true

require 'simplecov'

SimpleCov.start 'rails'

require 'minitest/reporters'

Minitest::Reporters.use!

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require_relative '../test/dummy/config/environment'
ActiveRecord::Migrator.migrations_paths = [File.expand_path('../test/dummy/db/migrate', __dir__)]
require 'rails/test_help'

# Filter out the backtrace from minitest while preserving the one from other libraries.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path('fixtures', __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + '/files'
  ActiveSupport::TestCase.fixtures :all
end

module ActiveSupport
  class TestCase
    parallelize workers: :number_of_processors
    parallelize_setup do |worker|
      SimpleCov.command_name "#{SimpleCov.command_name} worker #{worker}"
    end
    parallelize_teardown do
      SimpleCov.result
    end

    setup { I18n.locale = I18n.default_locale }
    teardown { I18n.locale = I18n.default_locale }
  end
end

module RemoveUploadedFiles
  def setup
    super
    upload_files
  end

  def teardown
    super
    remove_uploaded_files
  end

  private

  def upload_files
    Spina::Image.all.each do |image|
      unless image.file.attached?
        file_fixture('dubrovnik.jpeg').then { |fixture| image.file.attach io: fixture.open, filename: fixture.basename }
      end
    end
    Spina::Attachment.all.each do |attachment|
      unless attachment.file.attached?
        file_fixture('blank.pdf').then { |fixture| attachment.file.attach io: fixture.open, filename: fixture.basename }
      end
    end
  end

  def remove_uploaded_files
    Spina::Image.all.each { |image| image.file.purge }
    Spina::Attachment.all.each { |attachment| attachment.file.purge }
  end
end

module CustomAssertions
  protected

  def in_locales(*locales, include_default: true)
    yield if include_default
    locales.each do |locale|
      I18n.locale = locale
      yield
    end
  end

  def assert_markdown_component(*args, &blk)
    assert_select 'div.markdown-body', *args, &blk
  end

  def assert_slideshow(*args, &blk)
    assert_select '[data-controller="slideshow"]', *args, &blk
  end

  def assert_slide(*args, &blk)
    assert_select 'img[data-slideshow-target="slide"]:match(\'src\', ?)', %r{/rails/active_storage/representations/}, *args, &blk
  end

  def assert_button_link(href_or_arg, *args, &blk)
    case href_or_arg
    when String, Regexp
      assert_select 'a.btn:match(\'href\', ?)', href_or_arg, *args, &blk
    when NilClass
      assert_select 'a.btn', *args, &blk
    else
      assert_select 'a.btn', href_or_arg, *args, &blk
    end
  end

  def assert_link(href_or_arg, *args, &blk)
    case href_or_arg
    when String, Regexp
      assert_select 'a:match(\'href\', ?)', href_or_arg, *args, &blk
    when NilClass
      assert_select 'a', *args, &blk
    else
      assert_select 'a', href_or_arg, *args, &blk
    end
  end

  def assert_structure(structure_or_arg, *args, &blk)
    case structure_or_arg
    when Spina::Structure
      assert_select 'ul.structure:match(\'id\', ?)', ActionView::RecordIdentifier.dom_id(structure_or_arg), *args, &blk
    when NilClass
      assert_select 'ul.structure', *args, &blk
    else
      assert_select 'ul.structure', structure_or_arg, *args, &blk
    end
  end
end

module ActionDispatch
  class IntegrationTest
    prepend RemoveUploadedFiles
    prepend CustomAssertions
  end
end
