# frozen_string_literal: true

require 'test_helper'

module Spina
  module Conferences
    module PrimerTheme
      class PresentationsNavigationTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        test 'view a presentation' do
          presentation = spina_admin_conferences_presentations(:asymmetry_and_antisymmetry)
          in_locales :en, :'en-GB' do
            get frontend_presentation_path(presentation)
            assert_response :success
            assert_select 'main' do
              assert_select 'h1', presentation.title
              assert_select 'ul' do
                assert_select 'li > address', presentation.presenters.collect(&:full_name_and_institution).to_sentence
                assert_select 'li > time', I18n.localize(presentation.start_datetime, format: :short)
                assert_select 'li > address', "#{presentation.session.room_name}, #{presentation.room.institution.name}"
              end
              assert_markdown_component presentation.abstract
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
                assert_button_link text: attachment.name
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
              assert_button_link false
            end
          end
        end
      end
    end
  end
end
