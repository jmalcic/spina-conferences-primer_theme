# frozen_string_literal: true

require 'test_helper'

module Spina
  module Conferences
    module PrimerTheme
      class Test < ActiveSupport::TestCase
        test 'truth' do
          assert_kind_of Module, Spina::Conferences::PrimerTheme
        end
      end
    end
  end
end
