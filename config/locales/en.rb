# frozen_string_literal: true

{
  en: {
    date: {
      formats: {
        full: ->(time, _) { "%A, #{time.day.ordinalize} %B %Y" }
      }
    }
  }
}
