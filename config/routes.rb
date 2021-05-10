# frozen_string_literal: true

Spina::Engine.routes.draw do
  namespace :frontend, path: 'conferences', module: 'primer_theme/conferences' do
    resources :conferences, only: %i[index show] do
      resources :presentations, only: [:show]
    end
    resources :presentations, only: [:show]
    get 'cookies-info', controller: 'application'
  end

  namespace :frontend, path: 'journal', module: 'primer_theme/journal' do
    resources :issues, only: %i[index show] do
      resources :articles, only: %i[show]
    end
  end
end
