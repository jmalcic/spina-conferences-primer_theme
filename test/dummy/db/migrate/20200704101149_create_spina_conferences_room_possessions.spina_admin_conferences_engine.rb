# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20180916135432)

class CreateSpinaConferencesRoomPossessions < ActiveRecord::Migration[5.2] # :nodoc:
  def change
    create_table :spina_conferences_room_possessions do |t| # rubocop:disable Rails/CreateTableWithTimestamps
      t.references :room, foreign_key: { to_table: :spina_conferences_rooms }
      t.references :conference, foreign_key: { to_table: :spina_conferences_conferences }
    end
  end
end
