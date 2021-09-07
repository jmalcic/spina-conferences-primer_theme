module Spina
  module Parts
    module Conferences
      module PrimerTheme
        class Checkbox < Spina::Parts::Base
          # Booleans don't work nicely with Spina page parts, so we have this mess
          CHECKED_VALUE = "Archived"
          UNCHECKED_VALUE = "Current"

          attr_json :content, :string, default: UNCHECKED_VALUE
        end
      end
    end
  end
end
