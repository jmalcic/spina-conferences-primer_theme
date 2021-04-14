# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20181017155705)

class AddDependentOptionToForeignKeys < ActiveRecord::Migration[5.2] # :nodoc:
  def change # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    remove_foreign_key :spina_conferences_delegates, :spina_conferences_institutions, column: :institution_id
    remove_foreign_key :spina_conferences_presentations, :spina_conferences_room_uses, column: :room_use_id
    remove_foreign_key :spina_conferences_room_uses, :spina_conferences_room_possessions, column: :room_possession_id
    remove_foreign_key :spina_conferences_room_uses, :spina_conferences_presentation_types, column: :presentation_type_id
    remove_foreign_key :spina_conferences_room_possessions, :spina_conferences_rooms, column: :room_id
    remove_foreign_key :spina_conferences_room_possessions, :spina_conferences_conferences, column: :conference_id
    remove_foreign_key :spina_conferences_rooms, :spina_conferences_institutions, column: :institution_id
    remove_foreign_key :spina_conferences_institutions, :spina_images, column: :logo_id
    remove_foreign_key :spina_conferences_presentation_types, :spina_conferences_conferences, column: :conference_id
    remove_foreign_key :spina_conferences_conferences, :spina_conferences_institutions, column: :institution_id
    add_foreign_key :spina_conferences_delegates, :spina_conferences_institutions,
                    column: :institution_id, on_delete: :cascade
    add_foreign_key :spina_conferences_presentations, :spina_conferences_room_uses,
                    column: :room_use_id, on_delete: :cascade
    add_foreign_key :spina_conferences_room_uses, :spina_conferences_room_possessions,
                    column: :room_possession_id, on_delete: :cascade
    add_foreign_key :spina_conferences_room_uses, :spina_conferences_presentation_types,
                    column: :presentation_type_id, on_delete: :cascade
    add_foreign_key :spina_conferences_room_possessions, :spina_conferences_rooms,
                    column: :room_id, on_delete: :cascade
    add_foreign_key :spina_conferences_room_possessions, :spina_conferences_conferences,
                    column: :conference_id, on_delete: :cascade
    add_foreign_key :spina_conferences_rooms, :spina_conferences_institutions,
                    column: :institution_id, on_delete: :cascade
    add_foreign_key :spina_conferences_institutions, :spina_images, column: :logo_id,
                                                                    on_delete: :cascade
    add_foreign_key :spina_conferences_presentation_types, :spina_conferences_conferences,
                    column: :conference_id, on_delete: :cascade
    add_foreign_key :spina_conferences_conferences, :spina_conferences_institutions,
                    column: :institution_id, on_delete: :cascade
  end
end
