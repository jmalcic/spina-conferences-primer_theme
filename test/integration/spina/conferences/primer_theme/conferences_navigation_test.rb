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
              assert_select 'ul.admin_conferences_conference' do
                Spina::Admin::Conferences::Conference.sorted.each do |conference|
                  assert_select "li#admin_conferences_conference_#{conference.id}" do
                    assert_select 'ul.admin_conferences_institution' do
                      assert_institution_logos_for conference
                    end
                    assert_select 'div.flex-auto' do
                      assert_select 'h3', conference.name
                      assert_select 'ul' do
                        assert_select 'li', text: "#{I18n.localize(conference.start_date, format: :date)}–" \
                                                  "#{I18n.localize(conference.finish_date, format: :long)}"
                        if conference.institutions.any?
                          assert_select 'li > address', text: "#{conference.institutions.pluck(:name).to_sentence}, " \
                                                              "#{conference.institutions.pluck(:city).uniq.to_sentence}"
                        else
                          assert_select 'li > address', false
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
              assert_conference_info_for conference
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
              assert_no_conference_parts_for conference
            end
          end
        end

        test 'view a conference without partables' do
          conference = spina_admin_conferences_conferences :conference_without_partables
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_select 'main' do
              assert_no_conference_parts_for conference
            end
          end
        end

        test 'view a conference with old submission info' do
          conference = spina_admin_conferences_conferences :conference_with_old_submission_info
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_select 'main' do
              assert_no_submission_info_for conference
            end
          end
        end

        test 'view a conference with current submission info' do
          conference = spina_admin_conferences_conferences :conference_with_current_submission_info
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_select 'main' do
              assert_submission_info_for conference
            end
          end
        end

        test 'view a conference without submission info' do
          conference = spina_admin_conferences_conferences :conference_without_submission_info
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_select 'main' do
              assert_no_submission_info_for conference
            end
          end
        end

        test 'view a conference without submission info partables' do
          conference = spina_admin_conferences_conferences :conference_without_submission_info_partables
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_select 'main' do
              assert_no_submission_info_for conference
            end
          end
        end

        test 'view a conference with institutions' do
          conference = spina_admin_conferences_conferences :conference_with_institutions
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_select 'main' do
              assert_institutions_for conference
            end
          end
        end

        test 'view a conference without institutions' do
          conference = spina_admin_conferences_conferences :conference_without_institutions
          in_locales :en, :'en-GB' do
            get frontend_conference_path(conference)
            assert_response :success
            assert_select 'main' do
              assert_no_institutions_for conference
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
            get frontend_conference_path(conference)
            assert_response :success
            assert_select 'main' do
              assert_no_presentations_for conference
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
            get frontend_conference_path(conference)
            assert_response :success
            assert_select 'main' do
              assert_no_events_for conference
            end
          end
        end

        private

        def assert_conference_info_for(conference)
          assert_select 'div.admin_conferences_conference' do
            assert_select 'h1', conference.name
            assert_select 'ul > li', text: "#{I18n.localize(conference.start_date, format: :date)}–" \
                                          "#{I18n.localize(conference.finish_date, format: :long)}"
          end
        end

        def assert_conference_nav_for(conference)
          assert_select '#conference_tabs' do
            assert_select 'a', 'Information'
            assert_select 'a', 'Presentations'
            assert_select 'a', 'Events'
            assert_button_link frontend_conference_url(conference, protocol: :webcal, format: :ics), 'Subscribe'
          end
        end

        def assert_conference_parts_for(conference, present: true)
          assert_slideshow present do
            assert_slide 2
          end
          assert_markdown_component present ? conference.content(:text) : false
          assert_select 'h2', text: 'Sponsors', count: present ? 1 : 0
          assert_sponsors_for conference, present: present
        end

        def assert_sponsors_for(conference, present: true)
          assert_select 'div.structure', present do
            assert_select 'a img', count: conference.content(:sponsors).structure_items.joins(:structure_parts)
                                                     .where(spina_structure_parts: { name: 'logo', structure_partable_id: nil }).count
            conference.content(:sponsors).structure_items.joins(:structure_parts)
                      .where.not(spina_structure_parts: { name: 'logo', structure_partable_id: nil }).each do |sponsor|
              assert_select 'a', sponsor.content(:name)
            end
          end
        end

        def assert_no_conference_parts_for(conference)
          assert_conference_parts_for(conference, present: false)
        end

        def assert_submission_info_for(conference, present: true)
          assert_select 'div.flash.flash-warn.admin_conferences_conference', present do
            assert_button_link conference.content(:submission_url), text: 'Submit an abstract'
            assert_select 'div', "Submit abstracts by #{I18n.localize(conference.content(:submission_date), format: :full)}"
            assert_select 'div', conference.content(:submission_text)
          end
        end

        def assert_no_submission_info_for(conference)
          assert_submission_info_for(conference, present: false)
        end

        def assert_institutions_for(conference, present: true)
          assert_select 'div.admin_conferences_conference' do
            assert_select 'h1', conference.name
            if present
              assert_select 'ul > li > address', text: "#{conference.institutions.pluck(:name).to_sentence}, "\
                                             "#{conference.institutions.pluck(:city).uniq.to_sentence}"
            else
              assert_select 'ul > li > address', false
            end
            assert_select 'ul.admin_conferences_institution', present do
              assert_institution_logos_for conference
            end
          end
        end

        def assert_institution_logos_for(conference)
          assert_select 'li img', count: conference.institutions.where.not(logo: nil).count
          conference.institutions.where(logo: nil).each do |institution|
            assert_select 'li', institution.name
          end
        end

        def assert_no_institutions_for(conference)
          assert_institutions_for(conference, present: false)
        end

        def assert_presentations_for(conference, present: true)
          assert_select 'ul.admin_conferences_presentation', present do
            assert_select 'li' do
              conference.presentations.each do |presentation|
                assert_select 'div', I18n.localize(presentation.start_datetime, format: :short)
                assert_select 'address', presentation.session.room_name
                assert_select 'h3', presentation.title
                assert_select 'address', presentation.presenters.collect(&:full_name_and_institution).to_sentence
              end
            end
          end
        end

        def assert_no_presentations_for(conference)
          assert_presentations_for(conference, present: false)
        end

        def assert_events_for(conference, present: true)
          assert_select 'ul.admin_conferences_event', present do
            assert_select 'li' do
              conference.events.each do |event|
                assert_select 'div', "#{I18n.localize(event.start_time, format: :short)}–#{I18n.localize(event.finish_time, format: :time)}"
                assert_select 'address', event.location
                assert_select 'h3', event.name
                assert_select 'div', event.description.try(:html_safe)
              end
            end
          end
        end

        def assert_no_events_for(conference)
          assert_events_for(conference, present: false)
        end
      end
    end
  end
end
