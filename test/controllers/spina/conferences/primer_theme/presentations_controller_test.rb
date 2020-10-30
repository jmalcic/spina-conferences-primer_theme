# frozen_string_literal: true

require 'test_helper'

module Spina
  module Conferences
    module PrimerTheme
      class PresentationsControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup { @presentation = spina_admin_conferences_presentations :asymmetry_and_antisymmetry }

        test 'should show presentation' do
          get frontend_presentation_url(@presentation)
          assert_response :success
        end
      end
    end
  end
end
