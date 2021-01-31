# frozen_string_literal: true

require 'test_helper'

module Spina
  module Conferences
    module PrimerTheme
      class NavigationsHelperTest < ActionView::TestCase
        test 'should return main navigation items' do
          assert_not_empty main_navigation_items
          NavigationItem.joins(:navigation).where(spina_navigations: { name: 'main' }).destroy_all
          assert_empty main_navigation_items
        end

        test 'should return footer navigation items' do
          assert_not_empty footer_navigation_items
          NavigationItem.joins(:navigation).where(spina_navigations: { name: 'footer' }).destroy_all
          assert_empty footer_navigation_items
        end
      end
    end
  end
end
