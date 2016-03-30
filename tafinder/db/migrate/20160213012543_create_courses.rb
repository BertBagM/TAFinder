class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string  :subject, limit: 4, null: false
      t.string  :number, limit: 3, null: false
      t.string  :graduate, limit: 1, default: "U", null: false
      t.integer :term_id, null: false

      t.timestamps null: false
    end
  end
end
