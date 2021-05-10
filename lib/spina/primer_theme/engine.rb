# frozen_string_literal: true

module Spina
  module PrimerTheme
    class Engine < ::Rails::Engine
      config.to_prepare do
        ::Spina::PagesController.helper 'spina/primer_theme/application'
      end
    end
  end
end
