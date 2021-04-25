# frozen_string_literal: true

module Spina
  module Journal
    module PrimerTheme
      # User-facing controller for journal issues
      class IssuesController < ApplicationController
        before_action :set_journal
        before_action :set_issue, :set_breadcrumb, only: :show
        before_action :set_metadata

        def index
          # having multiple journals is not currently allowed anyway
          @issues = Admin::Journal::Issue.sorted_desc
        end

        def show
          add_breadcrumb t('spina.journal.primer_theme.volume_issue', volume_number: @issue.volume.number, issue_number: @issue.number)
        end

        private

        def set_journal
          @journal = Admin::Journal::Journal.instance
        rescue ActiveRecord::RecordNotFound
          send_file Rails.root.join('public/404.html'), type: 'text/html; charset=utf-8', status: 404
        end

        def set_issue
          @issue = Admin::Journal::Issue.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          send_file Rails.root.join('public/404.html'), type: 'text/html; charset=utf-8', status: 404
        end

        def set_breadcrumb
          add_breadcrumb @journal.name, frontend_issues_path
          add_breadcrumb Admin::Journal::Issue.model_name.human.pluralize, frontend_issues_path
        end

        def set_metadata
          @title = @journal.name
          @description = @journal.content(:description).try(:to_plain_text)
        end
      end
    end
  end
end
