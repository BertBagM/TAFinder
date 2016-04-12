class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string  :number, limit: 3
      t.string  :instructor_name
      t.string  :act_type, limit: 3
      t.string  :days, limit: 5, default: ""
      t.time    :start_time
      t.time    :end_time
      t.integer :lab_hours, default: 0
      t.integer :marking_hours, default: 0
      t.integer :coord_hours, default: 0
      t.integer :enrolled_est, default: 0
      t.integer :enrolled, default: 0
      t.integer :released, default: 0
      t.string  :ta_name
      t.integer :capacity, default: 0
      t.string  :building, limit: 3
      t.string  :room, limit: 4
      t.integer :course_id, null: false

      t.timestamps null: false
    end
  end
end
