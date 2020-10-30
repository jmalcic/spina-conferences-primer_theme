# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20181009130631)

class RenameSpinaPageParts < ActiveRecord::Migration[5.2] # :nodoc:
  def change
    rename_table 'spina_dates', 'spina_conferences_dates'
    rename_table 'spina_email_addresses', 'spina_conferences_email_addresses'
    rename_table 'spina_urls', 'spina_conferences_urls'
    rename_table 'spina_times', 'spina_conferences_times'
  end
end
