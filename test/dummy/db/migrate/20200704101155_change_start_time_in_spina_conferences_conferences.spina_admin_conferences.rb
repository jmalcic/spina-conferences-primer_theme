# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20181012213049)

class ChangeStartTimeInSpinaConferencesConferences < ActiveRecord::Migration[5.2] # :nodoc:
  def up
    remove_column :spina_conferences_presentations, :date
    remove_column :spina_conferences_presentations, :start_time
    add_column :spina_conferences_presentations, :start_time, :datetime
  end

  def down
    remove_column :spina_conferences_presentations, :start_time
    add_column :spina_conferences_presentations, :date, :date
    add_column :spina_conferences_presentations, :start_time, :time
  end
end
