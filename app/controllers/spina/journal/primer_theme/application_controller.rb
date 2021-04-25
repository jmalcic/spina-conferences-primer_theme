# frozen_string_literal: true

module Spina
  module Journal
    module PrimerTheme
      # Base class from which controllers related to the journal plugin inherit
      class ApplicationController < Spina::ApplicationController
        def cookies_info
          render partial: 'cookies'
        end
      end
    end
  end
end
