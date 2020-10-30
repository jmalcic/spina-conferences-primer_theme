# frozen_string_literal: true

require 'test_helper'

module Spina
  module Conferences
    class PresentationsNavigationTest < ActionDispatch::IntegrationTest
      include ::Spina::Engine.routes.url_helpers

      test 'view a presentation' do
        presentation = spina_admin_conferences_presentations(:asymmetry_and_antisymmetry)
        in_locales :en do
          get frontend_presentation_path(presentation)
          assert_response :success
          assert_select 'h1', presentation.title
          assert_select 'ul' do
            assert_select 'li:nth-child(1)' do
              assert_select 'address', presentation.presenters.collect(&:full_name_and_institution).to_sentence
            end
            assert_select 'li:nth-child(2)' do
              assert_select 'time', I18n.localize(presentation.start_datetime, format: :short)
            end
            assert_select 'li:nth-child(3)' do
              assert_select 'address', "#{presentation.session.room_name}, #{presentation.room.institution.name}"
            end
          end
          assert_markdown_component presentation.abstract
        end
      end

      test 'view a presentation with attachments' do
        presentation = spina_admin_conferences_presentations(:presentation_with_attachments)
        in_locales :en do
          get frontend_presentation_path(presentation)
          assert_response :success
          presentation.attachments.each do |attachment|
            assert_button_link %r{/rails/active_storage/blobs/}, text: attachment.name
          end
        end
      end

      test 'view a presentation without attachments' do
        presentation = spina_admin_conferences_presentations(:presentation_without_attachments)
        in_locales :en do
          get frontend_presentation_path(presentation)
          assert_button_link %r{/rails/active_storage/blobs/}, false
        end
      end
    end
  end
end
