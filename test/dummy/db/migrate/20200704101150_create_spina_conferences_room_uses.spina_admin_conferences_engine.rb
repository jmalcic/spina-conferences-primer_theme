# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20180916135433)

class CreateSpinaConferencesRoomUses < ActiveRecord::Migration[5.2] # :nodoc:
  def change
    create_table :spina_conferences_room_uses do |t| # rubocop:disable Rails/CreateTableWithTimestamps
      t.references :room_possession, foreign_key: { to_table: :spina_conferences_room_possessions }
      t.references :presentation_type, foreign_key: { to_table: :spina_conferences_presentation_types }
    end
  end
end
