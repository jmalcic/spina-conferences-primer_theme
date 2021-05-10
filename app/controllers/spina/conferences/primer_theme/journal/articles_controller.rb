# frozen_string_literal: true

module Spina
  module Conferences
    module PrimerTheme
      module Journal
        # User-facing controller for journal articles
        class ArticlesController < ApplicationController
          before_action :set_article, :set_issue, :set_breadcrumb, :set_metadata

          def show
            add_breadcrumb @article.title
          end

          private

          def set_article
            @article = Admin::Journal::Article.includes(affiliations: [:institution]).find(params[:id])
          rescue ActiveRecord::RecordNotFound
            send_file Rails.root.join('public/404.html'), type: 'text/html; charset=utf-8', status: 404
          end

          def set_issue
            @issue = Admin::Journal::Issue.includes(:volume, :articles).find(params[:issue_id])
          rescue ActiveRecord::RecordNotFound
            send_file Rails.root.join('public/404.html'), type: 'text/html; charset=utf-8', status: 404
          end

          def set_breadcrumb
            return if @issue.blank?

            add_breadcrumb Admin::Journal::Issue.model_name.human.pluralize, frontend_issues_path
            add_breadcrumb t('spina.conferences.primer_theme.journal.volume_issue', volume_number: @issue.volume.number, issue_number: @issue.number),
                          frontend_issue_path(@issue.id)
          end

          def set_metadata
            @title = @article.title
            @description = @article.content(:abstract).try(:to_plain_text)
          end
        end
      end
    end
  end
end
