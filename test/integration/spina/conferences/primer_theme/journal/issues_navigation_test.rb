# frozen_string_literal: true

require 'test_helper'

module Spina
  module Conferences
    module PrimerTheme
      module Journal
        class IssuesNavigationTest < ActionDispatch::IntegrationTest
          include ::Spina::Engine.routes.url_helpers

          test 'view issues' do
            get frontend_issues_path
            assert_response :success
            assert_select 'main' do
              assert_select 'ul' do
                Spina::Admin::Journal::Issue.sorted_desc.each do |issue|
                  assert_select 'li' do
                    assert_select 'h2', text: I18n.t('spina.conferences.primer_theme.journal.volume_issue',
                                                    volume_number: issue.volume.number,
                                                    issue_number: issue.number)
                    assert_select('h3', text: issue.title) if issue.title.present?
                    assert_select 'time', text: I18n.l(issue.date, format: :long)
                  end
                end
              end
            end
          end

          test 'view an issue' do
            issue = spina_admin_journal_issues(:vol1_issue1)
            get frontend_issue_path(issue)
            assert_response :success
            assert_select 'main' do
              assert_select 'h1', text: I18n.t('spina.conferences.primer_theme.journal.volume_issue',
                                              volume_number: issue.volume.number,
                                              issue_number: issue.number)
              assert_select 'h2', text: issue.title
              assert_select 'div#journal-articles-list' do
                assert_select 'ul' do
                  issue.articles.sorted_asc.each do |article|
                    assert_select 'li', text: Regexp.new(article.title)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
