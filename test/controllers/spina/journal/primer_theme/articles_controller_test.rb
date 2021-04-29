# frozen_string_literal: true

require 'test_helper'

module Spina
  module Journal
    module PrimerTheme
      class ArticlesControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          @article = spina_admin_journal_articles :new_wave
        end

        test 'should get show' do
          get frontend_issue_article_url(@article.issue, @article)
          assert_response :success
        end

        test 'should handle nonexistent article' do
          get frontend_issue_article_url(@article.issue, Spina::Admin::Journal::Article.last.id + 1)
          assert_response :missing
        end

        test 'should handle nonexistent issue' do
          get frontend_issue_article_url(Spina::Admin::Journal::Issue.last.id + 1, @article)
          assert_response :missing
        end
      end
    end
  end
end
