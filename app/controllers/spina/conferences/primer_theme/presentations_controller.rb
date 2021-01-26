# frozen_string_literal: true

module Spina
  module Conferences
    module PrimerTheme
      # User-facing controller for presentations, serving both html and ics
      class PresentationsController < ApplicationController
        before_action :set_presentation, :set_conference, :set_breadcrumb, :set_metadata

        def show
          add_breadcrumb @presentation.name
          respond_to do |format|
            format.html
            format.ics { head :not_found }
          end
        end

        private

        def set_presentation
          @presentation = Admin::Conferences::Presentation.includes(:presenters, attachments: [attachment_type: [:translations]])
                                                          .find(params[:id])
        rescue ActiveRecord::RecordNotFound
          send_file Rails.root.join('public/404.html'), type: 'text/html; charset=utf-8', status: 404
        end

        def set_conference
          @conference = Admin::Conferences::Conference.find(params[:conference_id]) if params[:conference_id].present?
        end

        def set_breadcrumb
          return if @conference.blank?

          add_breadcrumb Admin::Conferences::Conference.model_name.human.pluralize, frontend_conferences_path
          add_breadcrumb @conference.name, frontend_conference_path(@conference)
        end

        def set_metadata
          @title = @presentation.name
          @description = helpers.strip_tags(@presentation.abstract)
        end
      end
    end
  end
end
