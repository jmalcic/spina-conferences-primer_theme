# frozen_string_literal: true

require 'test_helper'

module Spina
  module Journal
    module PrimerTheme
      class Test < ActiveSupport::TestCase
        test 'module exists' do
          assert_kind_of Module, Spina::Journal::PrimerTheme
        end
      end
    end
  end
end
