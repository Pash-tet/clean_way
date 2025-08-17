class CreatePrayers < ActiveRecord::Migration[8.0]
  def change
    create_table :prayers do |t|
      t.string :title, null: false
      t.string :text, null: false
      t.integer :order, null: false, default: 0
      t.references :user, foreign_key: true, index: true
      t.timestamps
    end
  end
end
