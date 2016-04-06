class CreateApplications < ActiveRecord::Migration

  def change
    create_table :applications do |t|
      t.integer   :student_id, null: false
      t.string    :first_name, null: false
      t.string    :last_name, null: false
      t.string    :email, null: false
      t.decimal   :gpa, precision: 5, scale: 2
      t.string    :faculty, null: false
      t.integer   :study_year, default: 1, null: false
      t.boolean   :graduate, default: false, null: false
      t.boolean   :full_time, default: false, null: false
      t.integer   :ubc_employee_id
      t.string    :program
      t.string    :gender, null: false
      t.string    :street, null: false
      t.string    :city, null: false
      t.string    :postal_code, null: false
      t.string    :home_phone, limit: 14
      t.string    :cell_phone, limit: 14
      t.boolean   :previous_ta, default: false, null: false
      t.integer   :preferred_hours, default: 12, null: false
      t.integer   :maximum_hours, default: 12, null: false
      t.integer   :term_id, null: false

      t.timestamps null: false
    end
  end

end
