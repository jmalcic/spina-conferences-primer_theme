# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20180916135434)

class CreateSpinaConferencesPresentations < ActiveRecord::Migration[5.2] # :nodoc:
  def change
    create_table :spina_conferences_presentations do |t|
      t.string :title
      t.date :date
      t.time :start_time
      t.text :abstract
      t.references :room_use, foreign_key: { to_table: :spina_conferences_room_uses }

      t.timestamps null: false
    end
  end
end
