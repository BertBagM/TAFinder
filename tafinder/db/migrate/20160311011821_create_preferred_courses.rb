class CreatePreferredCourses < ActiveRecord::Migration
  def change
    create_table :preferred_courses do |t|
      t.integer :application_id, null: false
      t.integer :course_id, null: false

      t.timestamps null: false
    end
  end
end
