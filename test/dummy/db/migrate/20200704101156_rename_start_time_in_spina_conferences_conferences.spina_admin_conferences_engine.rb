# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20181012214813)

class RenameStartTimeInSpinaConferencesConferences < ActiveRecord::Migration[5.2] # :nodoc:
  def change
    rename_column :spina_conferences_presentations, :start_time, :start_datetime
  end
end
