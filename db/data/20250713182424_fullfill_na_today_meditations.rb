# frozen_string_literal: true

class FullfillNaTodayMeditations < ActiveRecord::Migration[8.0]
  def up
    meditations = JSON.parse(File.read("db/seeds/na.json"))
    TodayMeditation.insert_all(meditations)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
