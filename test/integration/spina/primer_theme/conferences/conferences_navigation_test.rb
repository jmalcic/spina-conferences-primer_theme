# frozen_string_literal: true

require 'test_helper'

module Spina
  module Conferences
    module PrimerTheme
      class ConferencesNavigationTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        test 'view conferences' do
          in_locales :en, :'en-GB' do
            get frontend_conferences_path
            assert_response :success
            assert_select 'main' do
              assert_select 'ul' do
                Spina::Admin::Conferences::Conference.sorted.each do |conference|
                  assert_select 'li', text: Regexp.new(conference.name) do
                    assert_select 'ul' do
                      assert_institution_logos_for conference
                    end
                    assert_select 'div.flex-auto' do
                      assert_select 'h3', conference.name
                      assert_select 'ul' do
                        assert_select 'li', text: "#{I18n.localize(conference.start_date, format: :date)}–" \
                                                  "#{I18n.localize(conference.finish_date, format: :long)}"
                        if conference.institutions.any?
                          assert_select 'address', text: "#{conference.institutions.pluck(:name).to_sentence}, " \
                                                         "#{conference.institutions.pluck(:city).uniq.to_sentence}"
                        else
                          assert_select 'address', false
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end

        test 'view a conference' do
          conference = spina_admin_conferences_conferences :university_of_atlantis_2017
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_select 'main' do
              assert_select 'div', text: Regexp.new(conference.name) do
                assert_conference_info_for conference
              end
              assert_conference_nav_for conference
            end
          end
        end

        test 'view a conference with parts' do
          conference = spina_admin_conferences_conferences :conference_with_parts
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_select 'main' do
              assert_conference_parts_for conference
            end
          end
        end

        test 'view a conference without parts' do
          conference = spina_admin_conferences_conferences :conference_without_parts
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_select 'main' do
              assert_no_conference_parts
            end
          end
        end

        test 'view a conference without partables' do
          conference = spina_admin_conferences_conferences :conference_without_partables
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_select 'main' do
              assert_no_conference_parts
            end
          end
        end

        test 'view a conference with old submission info' do
          conference = spina_admin_conferences_conferences :conference_with_old_submission_info
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_no_submission_info
          end
        end

        test 'view a conference with current submission info' do
          conference = spina_admin_conferences_conferences :conference_with_current_submission_info
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_submission_info_for conference
          end
        end

        test 'view a conference without submission info' do
          conference = spina_admin_conferences_conferences :conference_without_submission_info
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_no_submission_info
          end
        end

        test 'view a conference without submission info partables' do
          conference = spina_admin_conferences_conferences :conference_without_submission_info_partables
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_no_submission_info
          end
        end

        test 'view a conference with institutions' do
          conference = spina_admin_conferences_conferences :conference_with_institutions
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_select 'main' do
              assert_select 'div:has(ul > li)', text: Regexp.new(conference.name) do
                assert_institutions_for conference
                assert_institution_logos_for conference
              end
            end
          end
        end

        test 'view a conference without institutions' do
          conference = spina_admin_conferences_conferences :conference_without_institutions
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_select 'main' do
              assert_select 'div', text: Regexp.new(conference.name) do
                assert_no_institutions
                assert_no_institution_logos
              end
            end
          end
        end

        test 'view a conference with presentations' do
          conference = spina_admin_conferences_conferences :conference_with_presentations
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference, tab: 'presentations')
            assert_response :success
            assert_select 'main' do
              assert_presentations_for conference
            end
          end
        end

        test 'view a conference without presentations' do
          conference = spina_admin_conferences_conferences :conference_without_presentations
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference, tab: 'presentations')
            assert_response :success
            assert_select 'main' do
              assert_no_presentations
            end
          end
        end

        test 'view a conference with events' do
          conference = spina_admin_conferences_conferences :conference_with_events
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference, tab: 'events')
            assert_response :success
            assert_select 'main' do
              assert_events_for conference
            end
          end
        end

        test 'view a conference without events' do
          conference = spina_admin_conferences_conferences :conference_without_events
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference, tab: 'events')
            assert_response :success
            assert_select 'main' do
              assert_no_events
            end
          end
        end

        private

        def assert_conference_info_for(conference)
          assert_select 'h1', conference.name
          assert_select 'ul > li', "#{I18n.localize(conference.start_date, format: :date)}–" \
                                   "#{I18n.localize(conference.finish_date, format: :long)}"
        end

        def assert_conference_nav_for(conference)
          assert_select '#conference_tabs' do
            assert_select 'a', 'Information'
            assert_select 'a', 'Presentations'
            assert_select 'a', 'Events'
            assert_button_link frontend_conference_url(conference, protocol: :webcal, format: :ics), 'Subscribe'
          end
        end

        def assert_conference_parts_for(conference)
          assert_slideshow conference.content(:gallery).present? do
            assert_slide conference.content(:gallery).count
          end
          assert_markdown_component html: conference.content.html(:text)
          assert_sponsors_for conference
        end

        def assert_no_conference_parts
          assert_no_slideshow
          assert_no_markdown_component
          assert_no_sponsors
        end

        def assert_sponsors_for(conference)
          assert_select 'h2', 'Sponsors'
          conference.content(:sponsors)
                    .to_a
                    .select { |sponsor| sponsor.content(:logo).present? }
                    .each do |sponsor|
            assert_select 'a:match(\'href\', ?) img:match(\'src\', ?)', sponsor.content(:website),
                          main_app.url_for(sponsor.content(:logo).variant(resize_to_limit: [200, 60]))
          end
          conference.content(:sponsors)
                    .to_a
                    .select { |sponsor| sponsor.content(:logo).blank? }
                    .each do |sponsor|
            assert_select 'a:match(\'href\', ?)', sponsor.content(:website) || '', text: sponsor.content(:name)
          end
        end

        def assert_no_sponsors
          assert_select 'h2', text: 'Sponsors', count: 0
        end

        def assert_submission_info_for(conference)
          assert_button_link conference.content(:submission_url), text: 'Submit an abstract'
          assert_select 'div', "Submit abstracts by #{I18n.localize(conference.content(:submission_date), format: :full)}"
          assert_select 'div', conference.content(:submission_text)
        end

        def assert_no_submission_info
          assert_select 'div', text: /Submit abstracts by/, count: 0
        end

        def assert_institution_logos_for(conference)
          conference.institutions.where.not(logo: nil).each do |institution|
            assert_select 'ul > li > img:match(\'src\', ?)', main_app.url_for(institution.logo.variant(resize_to_limit: [300, 60]))
          end
          conference.institutions.where(logo: nil).each do |institution|
            assert_select 'ul > li', institution.name
          end
        end

        def assert_no_institution_logos
          assert_select 'ul > li > img', false
          assert_select 'ul > li:empty', false
          assert_select 'ul:empty', false
        end

        def assert_institutions_for(conference)
          assert_select 'ul > li > address', text: "#{conference.institutions.pluck(:name).to_sentence}, "\
                                                   "#{conference.institutions.pluck(:city).uniq.to_sentence}"
        end

        def assert_no_institutions
          assert_select 'ul > li > address', false
        end

        def assert_presentations_for(conference)
          assert_select 'div#presentation_list' do
            assert_select 'ul' do
              conference.presentations.each do |presentation|
                assert_select 'li', text: Regexp.new(presentation.title) do
                  assert_select 'div', I18n.localize(presentation.start_datetime, format: :short)
                  assert_select 'address', presentation.session.room_name
                  assert_select 'h3', presentation.title
                  assert_select 'address', presentation.presenters.collect(&:full_name_and_institution).to_sentence
                end
              end
            end
          end
        end

        def assert_no_presentations
          assert_select 'div#presentation_list' do
            assert_select 'h3', 'No presentations.'
          end
        end

        def assert_events_for(conference)
          assert_select 'div#event_list' do
            assert_select 'ul' do
              conference.events.each do |event|
                assert_select 'li', text: Regexp.new(event.name) do
                  assert_select 'div',
                                "#{I18n.localize(event.start_time, format: :short)}–#{I18n.localize(event.finish_time, format: :time)}"
                  assert_select 'address', event.location
                  assert_select 'h3', event.name
                  assert_select 'div.trix-content', event.description.to_plain_text
                end
              end
            end
          end
        end

        def assert_no_events
          assert_select 'div#event_list' do
            assert_select 'h3', 'No events.'
          end
        end
      end
    end
  end
end
