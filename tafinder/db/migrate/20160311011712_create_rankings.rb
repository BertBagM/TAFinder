class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :application_id, null: false
      t.decimal :position, precision: 5, scale: 3
      t.boolean :locked, default: false, null: false

      t.timestamps null: false
    end
  end
end
