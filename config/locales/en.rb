# frozen_string_literal: true

{
  en: {
    date: {
      formats: {
        full: ->(date, _) { "%A, #{date.day.ordinalize} %B %Y" },
        long_ordinal: ->(date, _) { "#{date.day.ordinalize} %B %Y" }
      }
    },
    time: {
      formats: {
        ordinal_datetime_with_year: ->(time, _) { "#{time.day.ordinalize} %B %Y, %R" }
      }
    }
  }
}
