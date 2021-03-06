# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20180907141235)

class CreateSpinaConferencesConferences < ActiveRecord::Migration[5.2] # :nodoc:
  def change
    create_table :spina_conferences_conferences do |t|
      t.daterange :dates
      t.references :institution, foreign_key: { to_table: :spina_conferences_institutions }

      t.timestamps null: false
    end
  end
end
