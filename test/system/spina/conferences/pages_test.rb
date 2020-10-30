# frozen_string_literal: true

require 'application_system_test_case'

module Spina
  module Conferences
    class PagesTest < ApplicationSystemTestCase
      test 'visiting the homepage' do
        visit spina_pages(:homepage).materialized_path
      end
    end
  end
end
