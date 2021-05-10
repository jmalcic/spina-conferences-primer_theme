# frozen_string_literal: true

require 'test_helper'

module Spina
  module Conferences
    module PrimerTheme
      module Journal
        class IssuesControllerTest < ActionDispatch::IntegrationTest
          include ::Spina::Engine.routes.url_helpers

          setup do
            @issue = spina_admin_journal_issues :vol1_issue1
          end

          test 'should get index' do
            get frontend_issues_url
            assert_response :success
          end

          test 'should get show' do
            get frontend_issue_url(@issue)
            assert_response :success
          end

          test 'should handle missing issue' do
            get frontend_issue_url(Spina::Admin::Journal::Issue.last.id + 1)
            assert_response :missing
          end
        end
      end
    end
  end
end
