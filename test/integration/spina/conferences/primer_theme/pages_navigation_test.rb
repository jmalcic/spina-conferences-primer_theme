# frozen_string_literal: true

require 'test_helper'

module Spina
  module Conferences
    module PrimerTheme
      class PagesNavigationTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        test 'visit homepage' do
          page = spina_pages(:homepage)
          in_locales :en do
            get page.materialized_path
            assert_response :success
            assert_slideshow do
              assert_slide 2
              assert_select 'h1', spina_accounts(:dummy).name
              assert_markdown_component
            end
          end
        end

        test 'visit homepage before conference' do
          latest_conference = Spina::Admin::Conferences::Conference.sorted.first
          travel_to 1.month.before(latest_conference.start_date)
          page = spina_pages(:homepage)
          in_locales :en do
            get page.materialized_path
            assert_response :success
            assert_slideshow do
              assert_slide 2
              assert_select 'h1', latest_conference.name
              assert_select 'address', latest_conference.institutions.pluck(:name).to_sentence
              assert_select 'time', I18n.localize(latest_conference.start_date, format: :day_and_month)
              assert_select 'time', I18n.localize(latest_conference.finish_date, format: :day_and_month)
              assert_markdown_component
              assert_link frontend_conference_path(latest_conference), 'More info'
            end
          end
        end

        test 'visit homepage without partables' do
          page = spina_pages(:homepage_without_partables)
          in_locales :en do
            get page.materialized_path
            assert_response :success
            assert_slideshow false
            assert_select 'div.bg-blue' do
              assert_select 'h1', spina_accounts(:dummy).name
              assert_markdown_component
            end
          end
        end

        test 'visit empty homepage' do
          page = spina_pages(:empty_homepage)
          in_locales :en do
            get page.materialized_path
            assert_response :success
            assert_slideshow false
            assert_select 'div.bg-blue' do
              assert_select 'h1', spina_accounts(:dummy).name
              assert_markdown_component
            end
          end
        end

        test 'visit information page' do
          page = spina_pages(:information)
          in_locales :en do
            get page.materialized_path
            assert_response :success
            assert_markdown_component page.content(:information)
          end
        end

        test 'visit empty information page' do
          page = spina_pages(:empty_information)
          in_locales :en do
            get page.materialized_path
            assert_response :success
            assert_markdown_component false
          end
        end

        test 'visit information page without partables' do
          page = spina_pages(:information_without_partables)
          in_locales :en do
            get page.materialized_path
            assert_response :success
            assert_markdown_component false
          end
        end

        test 'visit about page' do
          page = spina_pages(:about)
          in_locales :en do
            get page.materialized_path
            assert_response :success
            assert_markdown_component page.content(:text)
            assert_markdown_component page.content(:contact)
            assert_select 'div.clearfix' do
              assert_select 'div:nth-child(1)' do
                assert_select 'div', 'Constitution'
                assert_select 'div', "Uploaded #{I18n.localize(page.content(:constitution).created_at.to_date, format: :long)}"
                assert_button_link %r{/rails/active_storage/blobs/}, text: 'Download'
              end
              assert_select 'div:nth-child(2)' do
                assert_select 'div', 'Minutes'
                assert_structure page.content(:minutes) do
                  page.content(:minutes).structure_items.sorted_by_structure.each_with_index do |minutes_item, index|
                    assert_select "li:nth-child(#{index + 1})" do
                      if minutes_item.has_content?(:date)
                        assert_select 'div', "Minutes for #{I18n.localize(minutes_item.content(:date), format: :long)}" do
                          assert_select 'time', I18n.localize(minutes_item.content(:date), format: :long)
                        end
                      else
                        assert_select 'time', false
                      end
                      assert_button_link %r{/rails/active_storage/blobs/},
                                         text: 'Download', count: minutes_item.has_content?(:attachment) ? 1 : 0
                    end
                  end
                end
              end
            end
            assert_select 'div', 'Partner societies'
            assert_structure page.content(:partner_societies) do
              page.content(:partner_societies).structure_items.sorted_by_structure.each_with_index do |partner_society, index|
                assert_select "li:nth-child(#{index + 1})" do
                  assert_select 'div', partner_society.content(:name)
                  assert_button_link partner_society.content(:website),
                                     text: 'Website', count: partner_society.has_content?(:website) ? 1 : 0
                  assert_button_link "mailto:#{partner_society.content(:email_address)}",
                                     text: 'Email', count: partner_society.has_content?(:email_address) ? 1 : 0
                  assert_markdown_component html: partner_society.content(:description),
                                            count: partner_society.has_content?(:description) ? 1 : 0
                  assert_select 'img', count: partner_society.content(:logo)&.persisted? ? 1 : 0
                end
              end
            end
          end
        end

        test 'visit empty about page' do
          page = spina_pages(:empty_about)
          in_locales :en do
            get page.materialized_path
            assert_response :success
            assert_markdown_component false
            assert_select 'div.clearfix' do
              assert_select 'div:nth-child(1)' do
                assert_select 'div', 'Constitution'
                assert_select 'div', 'No constitution uploaded.'
              end
              assert_select 'div:nth-child(2)' do
                assert_select 'div', 'Minutes'
                assert_select 'div', 'No minutes added.'
              end
            end
            assert_select 'div', text: 'Partner societies', count: 0
            assert_structure false
          end
        end

        test 'visit about page without partables' do
          page = spina_pages(:about_without_partables)
          in_locales :en do
            get page.materialized_path
            assert_response :success
            assert_markdown_component false
            assert_select 'div.clearfix' do
              assert_select 'div:nth-child(1)' do
                assert_select 'div', 'Constitution'
                assert_select 'div', 'No constitution uploaded.'
              end
              assert_select 'div:nth-child(2)' do
                assert_select 'div', 'Minutes'
                assert_select 'div', 'No minutes added.'
              end
            end
            assert_select 'div', text: 'Partner societies', count: 0
            assert_structure false
          end
        end

        test 'visit committee page' do
          page = spina_pages(:committee)
          in_locales :en do
            get page.materialized_path
            assert_response :success
            assert_markdown_component page.content(:text)
            assert_structure page.content(:committee_bios) do
              page.content(:committee_bios).structure_items.sorted_by_structure.each_with_index do |committee_bio, index|
                assert_select "li:nth-child(#{index + 1})" do
                  assert_select 'img', count: committee_bio.content(:profile_picture)&.persisted? ? 1 : 0
                  assert_select 'div.flex-auto' do
                    assert_select 'div.flex-column' do
                      if committee_bio.has_content?(:name) && committee_bio.has_content?(:role)
                        assert_select 'h3', text: "#{committee_bio.content(:name)}, #{committee_bio.content(:role)}"
                      else
                        assert_select 'h3', text: committee_bio.content(:name), count: committee_bio.has_content?(:name) ? 1 : 0
                      end
                      assert_link committee_bio.content(:facebook_profile),
                                  text: 'Facebook', count: committee_bio.has_content?(:facebook_profile) ? 1 : 0
                      assert_link committee_bio.content(:twitter_profile),
                                  text: 'Twitter', count: committee_bio.has_content?(:twitter_profile) ? 1 : 0
                    end
                    assert_select 'div.flex-auto > div:not(.flex-column)',
                                  html: committee_bio.content(:bio), count: committee_bio.has_content?(:bio) ? 1 : 0
                  end
                end
              end
            end
          end
        end

        test 'visit empty committee page' do
          page = spina_pages(:empty_committee)
          in_locales :en do
            get page.materialized_path
            assert_response :success
            assert_markdown_component false
            assert_structure false
          end
        end

        test 'visit committee page without partables' do
          page = spina_pages(:committee_without_partables)
          in_locales :en do
            get page.materialized_path
            assert_response :success
            assert_markdown_component false
            assert_structure false
          end
        end

        test 'visit blank page' do
          in_locales :en do
            get spina_pages(:blank).materialized_path
            assert_response :success
            get spina_pages(:empty_blank).materialized_path
            assert_response :success
          end
        end
      end
    end
  end
end
