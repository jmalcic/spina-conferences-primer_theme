# frozen_string_literal: true

Spina::Engine.routes.draw do
  namespace :frontend, path: 'conferences', module: 'conferences/primer_theme' do
    resources :conferences, only: %i[index show] do
      resources :presentations, only: [:show]
    end
    resources :presentations, only: [:show]
    get 'cookies-info', controller: 'application'
    scope path: 'journal', module: 'journal' do
      resources :issues, only: %i[index show] do
        resources :articles, only: %i[show]
      end
    end
  end
end
