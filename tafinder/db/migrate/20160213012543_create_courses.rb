class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string  :subject, limit: 4, null: true
      t.string  :number, limit: 3, null: true
      t.string  :graduate, limit: 1, default: "U", null:true
      t.integer :term_id, null: true

      t.timestamps null: true
    end
  end
end
