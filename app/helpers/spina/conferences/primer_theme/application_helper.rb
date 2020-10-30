# frozen_string_literal: true

module Spina
  module Conferences
    module PrimerTheme
      # Base helper
      module ApplicationHelper
        def latest_conference
          Spina::Admin::Conferences::Conference.sorted.first
        end

        def breadcrumbs(options = {}, &block)
          render_breadcrumbs(builder: Breadcrumbs::Builder, **options, &block)
        end

        def ancestors
          return [] if current_page.blank?

          render Primer::BreadcrumbComponent.new(mb: 4) do
            current_page.ancestors.each do |ancestor|
              component.slot(:item, href: 'ancestor.materialized_path') { ancestor.menu_title }
            end
            component.slot(:item, selected: true) { menu_title }
          end
        end

        def author
          current_account.name
        end

        def description
          current_page.present? ? current_page.description : @description # rubocop:disable Rails/HelperInstanceVariable
        end

        def title
          # noinspection RailsI18nInspection
          t :'.title', title: current_page.present? ? current_page.title : @title, suffix: current_account.name # rubocop:disable Rails/HelperInstanceVariable
        end

        def seo_title
          # noinspection RailsI18nInspection
          t :'.title', title: current_page.present? ? current_page.seo_title : @title, suffix: current_account.name # rubocop:disable Rails/HelperInstanceVariable
        end

        def partable_for(*parts, parent: current_page)
          association = case parent
                        when Spina::Page then :page_partable
                        when Spina::StructureItem then :structure_partable
                        when Spina::Account then :layout_partable
                        else :partable
                        end
          part = parent.parts.find_by(name: parts)
          [part, part.try(association)]
        end

        def calendar(name:, &block)
          # noinspection SpellCheckingInspection
          Icalendar::Calendar.new.tap { |calendar| calendar.x_wr_calname = name }
                             .then(&:to_ical).then { |calendar| calendar.insert(calendar.index('END:VCALENDAR'), capture(&block)) }
        end
      end
    end
  end
end
