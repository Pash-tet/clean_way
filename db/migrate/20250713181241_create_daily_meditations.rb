class CreateDailyMeditations < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_meditations do |t|
      t.string :source, null: false, index: true
      t.string :title
      t.jsonb :entry
      t.integer :day, index: true
      t.integer :month, index: true
    end
  end
end
