# frozen_string_literal: true

module Spina
  module Conferences
    module PrimerTheme
      class Engine < ::Rails::Engine
        config.to_prepare do
          ::Spina::PagesController.helper 'spina/conferences/primer_theme/application'
        end
      end
    end
  end
end
