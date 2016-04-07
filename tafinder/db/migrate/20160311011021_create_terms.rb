class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string  :year, limit: 4, null: false
      t.string  :semester, default: "F/W", limit: 3, null: false
      t.boolean :open, default: false, null: false

      t.timestamps null: false
    end
  end
end
