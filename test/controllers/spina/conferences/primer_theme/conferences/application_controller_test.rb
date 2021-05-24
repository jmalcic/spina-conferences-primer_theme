# frozen_string_literal: true

require 'test_helper'

module Spina
  module Conferences
    module PrimerTheme
      module Conferences
        class ApplicationControllerTest < ActionDispatch::IntegrationTest
          include ::Spina::Engine.routes.url_helpers

          test 'should get cookies info' do
            get frontend_cookies_info_url
            assert_response :success
          end
        end
      end
    end
  end
end
