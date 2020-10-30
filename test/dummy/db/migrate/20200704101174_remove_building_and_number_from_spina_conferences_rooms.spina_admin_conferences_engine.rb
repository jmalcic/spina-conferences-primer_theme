# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200420121443)

class RemoveBuildingAndNumberFromSpinaConferencesRooms < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    remove_column :spina_conferences_rooms, :building, :string, null: false
    remove_column :spina_conferences_rooms, :number, :string, null: false
  end
end
