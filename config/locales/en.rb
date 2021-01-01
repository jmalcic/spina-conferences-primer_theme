# frozen_string_literal: true

{
  en: {
    date: {
      formats: {
        full: ->(time, _) { "%A, #{time.day.ordinalize} %B %Y" }
      }
    },
    time: {
      formats: {
        ordinal_datetime_with_year: ->(time, _) { "#{time.day.ordinalize} %b %Y, %R" }
      }
    }
  }
}
