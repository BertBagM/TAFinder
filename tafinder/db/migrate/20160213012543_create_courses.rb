class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string  :name
      t.string  :subject, limit: 4, null: false
      t.string  :number, limit: 3, null: false
      t.string  :section, limit: 3
      t.string  :act_type, limit: 3, null: false
      t.string  :days, limit: 5, default: "", null: false
      t.time    :start_time
      t.time    :end_time
      t.boolean :lab, default: false, null: false
      t.boolean :mark, default: false, null: false
      t.boolean :coord, default: false, null: false
      t.string  :graduate, default: "U", limit: 1, null: false
      t.integer :enrolled_est, default: 0, null: false
      t.integer :enrolled, default: 0, null: false
      t.integer :released, default: 0, null: false
      t.integer :capacity, default: 0, null: false
      t.string  :building, limit: 3
      t.string  :room, limit: 4

      t.timestamps null: false
    end
  end
end
