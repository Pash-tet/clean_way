# frozen_string_literal: true

class FullfillNaTodayMeditations < ActiveRecord::Migration[8.0]
  def up
    meditations = JSON.parse(File.read("db/seeds/daily_na.json"))
    TodayMeditation.insert_all(meditations)
  end

  def down
    TodayMeditation.daily_na.destroy_all
  end
end
