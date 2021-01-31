# frozen_string_literal: true

require 'test_helper'

module Spina
  module Conferences
    module PrimerTheme
      class ApplicationHelperTest < ActionView::TestCase
        test 'returns latest conference' do
          assert_equal Spina::Admin::Conferences::Conference.sorted.first, latest_conference
        end

        test 'renders ancestors' do
          Current.page = nil
          assert_empty ancestors
          Current.page = spina_pages(:about)
          assert_equal <<~HTML.strip, ancestors
            <nav aria-label="Breadcrumb" class="mb-4">
              <ol>
                  <li aria-current="page" class="breadcrumb-item  ">About</li>
              </ol>
            </nav>
          HTML
          Current.page = spina_pages(:page_with_ancestor)
          assert_equal <<~HTML.strip, ancestors
            <nav aria-label="Breadcrumb" class="mb-4">
              <ol>
                  <li class="breadcrumb-item  "><a href="/blank">Blank</a></li>
                  <li aria-current="page" class="breadcrumb-item  ">Page with ancestor</li>
              </ol>
            </nav>
          HTML
        end

        test 'returns partable for parent' do
          assert_equal [spina_page_parts(:about_page_text), spina_texts(:lipsum)], partable_for('text', parent: spina_pages(:about))
          assert_equal [spina_structure_parts(:agm_name), spina_lines(:lipsum)], partable_for('name', parent: spina_structure_items(:agm))
          assert_equal [spina_layout_parts(:alert), spina_lines(:lipsum)],
                       partable_for('current_conference_alert', parent: spina_accounts(:dummy))
          assert_equal [spina_admin_conferences_parts(:text), spina_texts(:lipsum)],
                       partable_for('text', parent: spina_admin_conferences_conferences(:university_of_atlantis_2017))
          Current.page = spina_pages(:about)
          assert_equal [spina_page_parts(:about_page_text), spina_texts(:lipsum)], partable_for('text')
          assert_raises do
            partable_for('text', parent: 1)
          end
        end

        test 'returns new calendar' do
          assert_equal <<~ICS, calendar(name: 'Name') { concat("Lorem ipsum\r\n") }
            BEGIN:VCALENDAR\r
            VERSION:2.0\r
            PRODID:icalendar-ruby\r
            CALSCALE:GREGORIAN\r
            X-WR-CALNAME:Name\r
            Lorem ipsum\r
            END:VCALENDAR\r
          ICS
          assert_equal <<~ICS, calendar(name: 'Name')
            BEGIN:VCALENDAR\r
            VERSION:2.0\r
            PRODID:icalendar-ruby\r
            CALSCALE:GREGORIAN\r
            X-WR-CALNAME:Name\r
            END:VCALENDAR\r
          ICS
          assert_raises do
            calendar(name: nil) { concat("Lorem ipsum\r\n") }
          end
        end
      end
    end
  end
end
