class DailyMeditation < ApplicationRecord
  enum :source, { daily_na: "daily_na", aa24: "aa24" }
end
