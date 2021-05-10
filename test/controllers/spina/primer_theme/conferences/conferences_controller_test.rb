# frozen_string_literal: true

require 'test_helper'

module Spina
  module PrimerTheme
    module Conferences
      class ConferencesControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup { @conference = spina_admin_conferences_conferences :university_of_atlantis_2017 }

        test 'should get index' do
          get frontend_conferences_url
          assert_response :success
        end

        test 'should show conference' do
          get frontend_conference_url(@conference)
          assert_response :success
        end

        test 'should handle missing conference' do
          get frontend_conference_url(Spina::Admin::Conferences::Conference.last.id + 1)
          assert_response :missing
        end

        test 'should show conference with presentation type' do
          get frontend_conference_url(@conference, presentation_type: @conference.presentation_types.first.id)
          assert_response :success
        end

        test 'should get index as ics' do
          get frontend_conferences_url(format: :ics)
          assert_response :success
        end

        test 'should show conference as ics' do
          get frontend_conference_url(@conference, format: :ics)
          assert_response :success
        end
      end
    end
  end
end
