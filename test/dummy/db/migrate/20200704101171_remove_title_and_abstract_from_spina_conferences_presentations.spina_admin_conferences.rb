# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200420120946)

class RemoveTitleAndAbstractFromSpinaConferencesPresentations < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    remove_column :spina_conferences_presentations, :title, :string, null: false
    remove_column :spina_conferences_presentations, :abstract, :text, null: false
  end
end
