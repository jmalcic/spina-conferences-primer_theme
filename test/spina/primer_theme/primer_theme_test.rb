# frozen_string_literal: true

require 'test_helper'

module Spina
  module PrimerTheme
    class Test < ActiveSupport::TestCase
      test 'truth' do
        assert_kind_of Module, Spina::PrimerTheme
      end
    end
  end
end
