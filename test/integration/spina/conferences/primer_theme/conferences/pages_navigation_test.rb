# frozen_string_literal: true

require 'test_helper'

module Spina
  module Conferences
    module PrimerTheme
      module Conferences
        class PagesNavigationTest < ActionDispatch::IntegrationTest
          include ::Spina::Engine.routes.url_helpers

          test 'visit homepage' do
            page = spina_pages(:homepage)
            in_locales :en, :'en-GB' do
              get page.materialized_path
              assert_response :success
              assert_select 'main' do
                assert_slideshow do
                  assert_slide 2
                end
                assert_select 'h1', spina_accounts(:dummy).name
                assert_markdown_component
              end
            end
          end

          test 'visit homepage before conference' do
            current_conference = Spina::Admin::Conferences::Conference.order(dates: :asc).first
            page = spina_pages(:homepage)
            travel_to 1.month.before(current_conference.start_date) do
              in_locales :en, :'en-GB' do
                get page.materialized_path
                assert_response :success
                assert_select 'main' do
                  assert_slideshow do
                    assert_slide 2
                  end
                  assert_select 'h1', current_conference.name
                  assert_select 'address', current_conference.institutions.pluck(:name).to_sentence
                  assert_select 'time', I18n.localize(current_conference.start_date, format: :day_and_month)
                  assert_select 'time', I18n.localize(current_conference.finish_date, format: :day_and_month)
                  assert_markdown_component
                  assert_link frontend_conference_path(current_conference), 'More info'
                end
              end
            end
          end

          test 'visit homepage without partables' do
            page = spina_pages(:homepage_without_partables)
            in_locales :en, :'en-GB' do
              get page.materialized_path
              assert_response :success
              assert_select 'main' do
                assert_slideshow false
                assert_select 'h1', spina_accounts(:dummy).name
                assert_markdown_component
              end
            end
          end

          test 'visit empty homepage' do
            page = spina_pages(:empty_homepage)
            in_locales :en, :'en-GB' do
              get page.materialized_path
              assert_response :success
              assert_select 'main' do
                assert_slideshow false
                assert_select 'h1', spina_accounts(:dummy).name
                assert_markdown_component
              end
            end
          end

          test 'visit information page' do
            page = spina_pages(:information)
            in_locales :en, :'en-GB' do
              get page.materialized_path
              assert_response :success
              assert_select 'main' do
                assert_markdown_component page.content(:information)
              end
            end
          end

          test 'visit empty information page' do
            page = spina_pages(:empty_information)
            in_locales :en, :'en-GB' do
              get page.materialized_path
              assert_response :success
              assert_select 'main' do
                assert_markdown_component false
              end
            end
          end

          test 'visit information page without partables' do
            page = spina_pages(:information_without_partables)
            in_locales :en, :'en-GB' do
              get page.materialized_path
              assert_response :success
              assert_select 'main' do
                assert_markdown_component false
              end
            end
          end

          test 'visit about page' do
            page = spina_pages(:about)
            in_locales :en, :'en-GB' do
              get page.materialized_path
              assert_response :success
              assert_select 'main' do
                assert_markdown_component html: page.content.html(:text)
                assert_markdown_component html: page.content.html(:contact)
                assert_select 'div.clearfix' do
                  assert_select 'div:nth-child(1)' do
                    assert_select 'div', 'Constitution'
                    assert_select 'div', "Uploaded #{I18n.l(Spina::Attachment.find(page.content(:constitution).attachment_id).created_at
                                                                            .to_date, format: :long)}"
                    assert_button_link text: 'Download'
                  end
                  assert_select 'div:nth-child(2)' do
                    assert_select 'div', 'Minutes'
                    assert_select 'ul' do
                      page.content(:minutes).each_with_index do |minutes_item, index|
                        assert_select "li:nth-child(#{index + 1})"  do
                          if minutes_item.content(:date).present?
                            assert_select 'div', "Minutes for #{I18n.localize(minutes_item.content(:date), format: :long)}" do
                              assert_select 'time', I18n.localize(minutes_item.content(:date), format: :long)
                            end
                          else
                            assert_select 'time', false
                          end
                          assert_button_link text: 'Download', count: minutes_item.content(:attachment).present? ? 1 : 0
                        end
                      end
                    end
                  end
                end
                assert_select 'div', 'Partner societies'
                assert_select 'ul' do
                  page.content(:partner_societies).each_with_index do |partner_society, index|
                    assert_select "li:nth-child(#{index + 1})" do
                      assert_select 'div', partner_society.content(:name)
                      assert_button_link partner_society.content(:website),
                                        text: 'Website', count: partner_society.content(:website).present? ? 1 : 0
                      assert_button_link "mailto:#{partner_society.content(:email_address)}",
                                        text: 'Email', count: partner_society.content(:email_address).present? ? 1 : 0
                      assert_markdown_component html: partner_society.content(:description),
                                                count: partner_society.content(:description).present? ? 1 : 0
                      assert_select 'img', count: partner_society.content(:logo).present? ? 1 : 0
                    end
                  end
                end
              end
            end
          end

          test 'visit empty about page' do
            page = spina_pages(:empty_about)
            in_locales :en, :'en-GB' do
              get page.materialized_path
              assert_response :success
              assert_select 'main' do
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
                assert_select 'div', text: 'Partner societies'
                assert_select 'div', text: 'No societies added.'
                assert_select 'ul', false
              end
            end
          end

          test 'visit about page without partables' do
            page = spina_pages(:about_without_partables)
            in_locales :en, :'en-GB' do
              get page.materialized_path
              assert_response :success
              assert_select 'main' do
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
                assert_select 'div', text: 'Partner societies'
                assert_select 'div', text: 'No societies added.'
                assert_select 'ul', false
              end
            end
          end

          test 'visit committee page' do
            page = spina_pages(:committee)
            in_locales :en, :'en-GB' do
              get page.materialized_path
              assert_response :success
              assert_select 'main' do
                assert_markdown_component html: page.content.html(:text)
                assert_select 'ul' do
                  page.content(:committee_bios).each_with_index do |committee_bio, index|
                    assert_select "li:nth-child(#{index + 1})" do
                      assert_select 'img', count: committee_bio.content(:profile_picture).present? ? 1 : 0
                      assert_select 'div.flex-auto' do
                        assert_select 'div.flex-column' do
                          if committee_bio.content(:name).present? && committee_bio.content(:role).present?
                            assert_select 'h3', text: "#{committee_bio.content(:name)}, #{committee_bio.content(:role)}"
                          else
                            assert_select 'h3', text: committee_bio.content(:name), count: committee_bio.content(:name).present? ? 1 : 0
                          end
                          assert_select 'h4',
                                        text: committee_bio.content(:institution), count: committee_bio.content(:institution).present? ? 1 : 0
                          assert_link committee_bio.content(:facebook_profile),
                                      text: 'Facebook', count: committee_bio.content(:facebook_profile).present? ? 1 : 0
                          assert_link committee_bio.content(:twitter_profile),
                                      text: 'Twitter', count: committee_bio.content(:twitter_profile).present? ? 1 : 0
                        end
                        assert_select 'div.flex-auto > div:not(.flex-column)',
                                      html: committee_bio.content(:bio), count: committee_bio.content(:bio).present? ? 1 : 0
                      end
                    end
                  end
                end
              end
            end
          end

          test 'visit empty committee page' do
            page = spina_pages(:empty_committee)
            in_locales :en, :'en-GB' do
              get page.materialized_path
              assert_response :success
              assert_select 'main' do
                assert_markdown_component false
                assert_select 'ul', false
              end
            end
          end

          test 'visit committee page without partables' do
            page = spina_pages(:committee_without_partables)
            in_locales :en, :'en-GB' do
              get page.materialized_path
              assert_response :success
              assert_select 'main' do
                assert_markdown_component false
                assert_select 'ul', false
              end
            end
          end

          test 'visit embedded form page' do
            page = spina_pages(:embedded_form)
            in_locales :en, :'en-GB' do
              get page.materialized_path
              assert_response :success
              assert_select 'main' do
                assert_markdown_component html: page.content.html(:text)
                assert_select 'div' do
                  assert_select 'iframe[src=?]', page.content(:embed_url)
                end
              end
            end
          end

          test 'visit empty embedded form page' do
            page = spina_pages(:empty_embedded_form)
            in_locales :en, :'en-GB' do
              get page.materialized_path
              assert_response :success
              assert_select 'main' do
                assert_markdown_component false
                assert_select 'iframe', false
              end
            end
          end

          test 'visit embedded form page without partables' do
            page = spina_pages(:embedded_form_without_partables)
            in_locales :en, :'en-GB' do
              get page.materialized_path
              assert_response :success
              assert_select 'main' do
                assert_markdown_component false
                assert_select 'iframe', false
              end
            end
          end

          test 'visit blank page' do
            in_locales :en, :'en-GB' do
              get spina_pages(:blank).materialized_path
              assert_response :success
              assert_select 'main'
              get spina_pages(:empty_blank).materialized_path
              assert_response :success
              assert_select 'main'
            end
          end
        end
      end
    end
  end
end
