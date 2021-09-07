# frozen_string_literal: true

class CreateSpinaPartsConferencesPrimerThemeCheckboxes < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    create_table :spina_parts_conferences_primer_theme_checkboxes, &:timestamps
  end
end
