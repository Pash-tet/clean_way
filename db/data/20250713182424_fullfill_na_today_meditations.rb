# frozen_string_literal: true

class FullfillNaTodayMeditations < ActiveRecord::Migration[8.0]
  def up
    meditations = JSON.parse(File.read("db/seeds/daily_na.json"))
    DailyMeditation.insert_all(meditations)
  end

  def down
    DailyMeditation.daily_na.destroy_all
  end
end
