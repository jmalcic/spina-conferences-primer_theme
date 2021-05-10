# frozen_string_literal: true

module Spina
  module PrimerTheme
    module Conferences
      # Base class from which controllers inherit
      class ApplicationController < Spina::ApplicationController
        def cookies_info
          render partial: 'cookies'
        end
      end
    end
  end
end
