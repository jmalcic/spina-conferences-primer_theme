# frozen_string_literal: true

module Spina
  module Conferences
    module PrimerTheme
      # User-facing controller for conferences, serving both html and ics
      class ConferencesController < ApplicationController
        before_action :set_conference, :set_tab, :set_presentation_type, :set_breadcrumb, only: :show
        before_action :set_metadata

        def index
          @conferences = Admin::Conferences::Conference.sorted.includes(institutions: [:logo])
          respond_to :html, :ics
        end

        def show
          add_breadcrumb @conference.name
          respond_to :html, :ics
        end

        private

        def set_conference
          @conference = Admin::Conferences::Conference.includes(:events, :institutions,
                                                                presentation_types: [:translations],
                                                                presentations: [session: [:room], presenters: [:institution]])
                                                      .find(params[:id])
        rescue ActiveRecord::RecordNotFound
          send_file Rails.root.join('public/404.html'), type: 'text/html; charset=utf-8', status: 404
        end

        def set_tab
          @tab = params[:tab] || 'information'
        end

        def set_presentation_type
          @presentation_type = if params[:presentation_type].present?
                                 @conference.presentation_types
                                            .includes(presentations: [session: [:room], presenters: [:institution]])
                                            .find(params[:presentation_type])
                               else
                                 @conference
                               end
        end

        def set_breadcrumb
          add_breadcrumb Admin::Conferences::Conference.model_name.human.pluralize, frontend_conferences_path
        end

        def set_metadata
          @title = @conference.present? ? @conference.name : Admin::Conferences::Conference.model_name.human(count: 0)
          @description = @conference.present? && @conference.has_content?(:text) ? helpers.strip_tags(@conference.content(:text)) : ''
        end
      end
    end
  end
end
