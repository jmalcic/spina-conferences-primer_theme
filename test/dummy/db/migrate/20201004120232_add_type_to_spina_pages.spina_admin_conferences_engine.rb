# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20180907141242)

class AddTypeToSpinaPages < ActiveRecord::Migration[5.2] #:nodoc:
  def change
    add_column :spina_pages, :type, :string
  end
end
