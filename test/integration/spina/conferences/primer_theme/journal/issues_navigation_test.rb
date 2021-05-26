# frozen_string_literal: true

require 'test_helper'

module Spina
  module Conferences
    module PrimerTheme
      module Journal
        class IssuesNavigationTest < ActionDispatch::IntegrationTest
          include ::Spina::Engine.routes.url_helpers

          test 'view issues' do
            log_out_admin

            get frontend_issues_path
            assert_response :success
            assert_select 'main' do
              assert_select 'div#journal-issues-list' do
                assert_select 'ul' do
                  Spina::Admin::Journal::Issue.sorted_desc.where('date <= ?', Time.zone.today).each do |issue|
                    assert_select 'li' do
                      assert_select 'h3', text: I18n.t('spina.conferences.primer_theme.journal.volume_issue',
                                                      volume_number: issue.volume.number,
                                                      issue_number: issue.number)
                      assert_select('h4', text: issue.title) if issue.title.present?
                      assert_select 'time', text: I18n.l(issue.date, format: :long)
                    end
                  end
                end
              end
            end
          end

          test 'view issues when there are no issues' do
            Spina::Admin::Journal::Issue.destroy_all
            get frontend_issues_path
            assert_response :success
            assert_select 'div#journal-issues-list' do
              assert_select 'h3', text: I18n.t('spina.conferences.primer_theme.journal.issues.index.no_issues')
            end
          end

          test 'view issues when there are no past issues' do
            log_out_admin

            Spina::Admin::Journal::Issue.destroy_all
            new_issue = Spina::Admin::Journal::Issue.create!(number: 1, volume: Spina::Admin::Journal::Volume.first, date: Time.zone.today + 1.day)
            get frontend_issues_path
            assert_response :success
            assert_select 'div#journal-issues-list' do
              assert_select 'h3', text: I18n.t('spina.conferences.primer_theme.journal.issues.index.no_issues')
            end
          end

          test 'view issues as admin when there are no past issues' do
            log_in_as_admin

            Spina::Admin::Journal::Issue.destroy_all
            new_issue = Spina::Admin::Journal::Issue.create!(number: 1, volume: Spina::Admin::Journal::Volume.first, date: Time.zone.today + 1.day)
            get frontend_issues_path
            assert_response :success
            assert_select 'main' do
              assert_select 'div#journal-issues-list' do
                assert_select 'ul' do
                  assert_select 'li' do
                    assert_select 'h3', text: I18n.t('spina.conferences.primer_theme.journal.volume_issue',
                                                    volume_number: new_issue.volume.number,
                                                    issue_number: new_issue.number)
                    assert_select 'time', text: I18n.l(new_issue.date, format: :long)
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
                  issue.articles.visible.sorted_asc.each do |article|
                    assert_select 'li', text: Regexp.new(article.title)
                  end
                end
              end
            end
          end

          private

          def log_in_as_admin
            user = spina_users :joe
            post admin_sessions_path, params: { email: user.email, password: 'password' }
          end

          def log_out_admin
            get admin_logout_path
          end
        end
      end
    end
  end
end
