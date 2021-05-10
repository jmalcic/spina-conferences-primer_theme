# frozen_string_literal: true

require 'test_helper'

module Spina
  module PrimerTheme
    module Conferences
      class PresentationsNavigationTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        test 'view a presentation' do
          presentation = spina_admin_conferences_presentations(:asymmetry_and_antisymmetry)
          in_locales :en do
            get frontend_presentation_path(presentation)
            assert_response :success
            assert_select 'main' do
              assert_select 'h1', 'The Asymmetry and Antisymmetry of Syntax'
              assert_select 'address', 'Joe Bloggs, University of Atlantis'
              assert_select 'time', '07 Apr 10:00'
              assert_select 'address', 'Lecture block 2, University of Atlantis'
              assert_markdown_component 'Lorem ipsum'
            end
          end
          in_locales :'en-GB' do
            get frontend_presentation_path(presentation)
            assert_response :success
            assert_select 'main' do
              assert_select 'h1', 'The Asymmetry and Antisymmetry of Syntax'
              assert_select 'address', 'Joe Bloggs, University of Atlantis'
              assert_select 'time', '07 Apr 10:00'
              assert_select 'address', 'Lecture block 2, University of Atlantis'
              assert_markdown_component 'Lorem ipsum'
            end
          end
        end

        test 'view a presentation with attachments' do
          presentation = spina_admin_conferences_presentations(:presentation_with_attachments)
          in_locales :en, :'en-GB' do
            get frontend_presentation_path(presentation)
            assert_response :success
            assert_select 'main' do
              presentation.attachments.each do |attachment|
                assert_button_link main_app.rails_blob_path(attachment.attachment.file), text: attachment.name
              end
            end
          end
        end

        test 'view a presentation without attachments' do
          presentation = spina_admin_conferences_presentations(:presentation_without_attachments)
          in_locales :en, :'en-GB' do
            get frontend_presentation_path(presentation)
            assert_response :success
            assert_select 'main' do
              assert_button_link(/\/rails\/active_storage\/blobs\//, false)
            end
          end
        end
      end
    end
  end
end
