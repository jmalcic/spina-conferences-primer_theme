module Spina
  module Parts
    module Conferences
      module PrimerTheme
        class Checkbox < Spina::Parts::Base
          # Booleans don't work nicely with Spina page parts, so we have this mess
          CHECKED_VALUE = "1"
          UNCHECKED_VALUE = "0"

          attr_json :content, :string, default: UNCHECKED_VALUE
        end
      end
    end
  end
end
