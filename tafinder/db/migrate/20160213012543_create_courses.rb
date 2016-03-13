class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string  :name
      t.string  :subject, limit: 4
      t.string  :number, limit: 3
      t.string  :section, limit: 3
      t.string  :term, limit: 3
      t.string  :act_type, limit: 3
      t.string  :days, limit: 5, default: ""
      t.time    :start_time
      t.time    :end_time
      t.string :lab, default: ""
      t.string :mark, default: ""
      t.string :coord, default: ""
      t.string  :graduate, default: "U", limit: 1
      t.integer :enrolled_est, default: 0
      t.integer :enrolled, default: 0
      t.integer :released, default: 0
      t.integer :capacity, default: 0
      t.string  :building, limit: 3
      t.string  :room, limit: 4

      t.timestamps null: false
    end
  end
end
