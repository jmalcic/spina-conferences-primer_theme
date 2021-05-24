# frozen_string_literal: true

require 'test_helper'

module Spina
  module Conferences
    module PrimerTheme
      class AssetHelperTest < ActionView::TestCase
        test 'returns srcset for attachment with variant options' do
          assert_equal({
                          main_app.url_for(Spina::Image.first.file.variant(resize_to_limit: [200, 200])) => '1x',
                          main_app.url_for(Spina::Image.first.file.variant(resize_to_limit: [400, 400])) => '2x',
                          main_app.url_for(Spina::Image.first.file.variant(resize_to_limit: [600, 600])) => '3x',
                          main_app.url_for(Spina::Image.first.file.variant(resize_to_limit: [800, 800])) => '4x'
                        },
                        srcset(Spina::Image.first.file, variant: { resize_to_limit: [200, 200] }))
        end

        test 'returns srcset for attachment with variant options and factors' do
          assert_equal({ main_app.url_for(Spina::Image.first.file.variant(resize_to_limit: [200, 200])) => '1x' },
                        srcset(Spina::Image.first.file, factors: [1], variant: { resize_to_limit: [200, 200] }))
        end

        test 'returns nil for attachment without variant options' do
          assert_nil srcset(Spina::Image.first.file)
        end

        test 'returns nil for blank image' do
          assert_nil srcset(nil, variant: { resize_to_limit: [200, 200] })
        end

        test 'does not resize all variant options' do
          assert_equal({
                          main_app.url_for(Spina::Image.first.file.variant(resize_to_limit: [200, 200], rotate: 90)) => '1x',
                          main_app.url_for(Spina::Image.first.file.variant(resize_to_limit: [400, 400], rotate: 90)) => '2x',
                          main_app.url_for(Spina::Image.first.file.variant(resize_to_limit: [600, 600], rotate: 90)) => '3x',
                          main_app.url_for(Spina::Image.first.file.variant(resize_to_limit: [800, 800], rotate: 90)) => '4x'
                        },
                        srcset(Spina::Image.first.file, variant: { resize_to_limit: [200, 200], rotate: 90 }))
        end
      end
    end
  end
end
