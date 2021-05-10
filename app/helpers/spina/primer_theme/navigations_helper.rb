# frozen_string_literal: true

module Spina
  module PrimerTheme
    # Helper for accessing navigation items
    module NavigationsHelper
      def main_navigation_items
        @main_navigation_items ||= live_navigation_items('main')
      end

      def footer_navigation_items
        @footer_navigation_items ||= live_navigation_items('footer')
      end

      private

      def live_navigation_items(name)
        ::Spina::NavigationItem.joins(:navigation).where(spina_navigations: { name: name }).roots.regular_pages.in_menu.live.sorted
      end
    end
  end
end
