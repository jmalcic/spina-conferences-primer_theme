# frozen_string_literal: true

module Spina
  module PrimerTheme
    module Conferences
      # Base helper
      module ApplicationHelper
        include Spina::PagesHelper

        # Because the upper bound is exclusive a conference is current the day after it ends
        def current_conference
          Spina::Admin::Conferences::Conference.order(dates: :asc).find_by('upper(dates) >= ?', Date.today)
        end

        def ancestors
          return [] if current_page.blank?

          render Primer::BreadcrumbComponent.new(mb: 4) do |component|
            current_page.ancestors.each do |ancestor|
              component.item(href: ancestor.materialized_path) { ancestor.menu_title }
            end
            component.item(selected: true) { current_page.menu_title }
          end
        end

        def calendar(name:)
          Icalendar::Calendar.new
                             .tap { |calendar| calendar.x_wr_calname = name }
                             .tap { |calendar| yield(calendar) }
                             .tap(&:publish)
                             .then(&:to_ical)
        end
      end
    end
  end
end
