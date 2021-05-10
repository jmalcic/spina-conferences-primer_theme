# frozen_string_literal: true

class ChangeSpinaAccountThemeName < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        Spina::Account.all.each do |account|
          if account.preferences[:theme] == 'conferences_primer_theme'
            account.preferences[:theme] = 'primer_theme'
            account.save!
          end
        end
      end
      dir.down do
        Spina::Account.all.each do |account|
          if account.preferences[:theme] == 'primer_theme'
            account.preferences[:theme] = 'conferences_primer_theme'
            account.save!
          end
        end
      end
    end
  end
end

module Spina
  class Account < ::Spina::ApplicationRecord
    serialize :preferences
  end
end
