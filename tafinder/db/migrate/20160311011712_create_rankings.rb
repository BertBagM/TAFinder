class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :application_id, null: false
      t.integer :term_id, null: false
      t.integer :position
      t.boolean :locked, default: false, null: false

      t.timestamps null: false
    end
  end
end
