# frozen_string_literal: true

module Spina
  module Conferences
    module PrimerTheme
      # Base helper
      module ApplicationHelper
        include Spina::PagesHelper

        def latest_conference
          Spina::Admin::Conferences::Conference.sorted.first
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

        def partable_for(*part_names, parent: current_page)
          association = case parent
                        when Spina::Page then :page_partable
                        when Spina::StructureItem then :structure_partable
                        when Spina::Account then :layout_partable
                        else :partable
                        end
          parts = parent.parts.where(name: part_names)
          partables = parts.collect { |part| part.try(association) }
          [*parts, *partables]
        end

        def calendar(name:, &block)
          # noinspection SpellCheckingInspection
          block ||= proc { '' }
          Icalendar::Calendar.new.tap { |calendar| calendar.x_wr_calname = name }
                             .then(&:to_ical).then { |calendar| calendar.insert(calendar.index('END:VCALENDAR'), capture(&block)) }
        end
      end
    end
  end
end
