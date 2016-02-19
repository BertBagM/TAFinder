class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
    	t.integer	:studentNum
    	t.string	:firstName
    	t.string	:lastName
    	t.string	:emailAddress
    	t.decimal :GPA
    	t.string	:faculty
    	t.integer	:yearOfStudy
    	t.boolean	:graduateStudent
    	t.integer	:ubcEmployeeId
    	t.string	:program
    	t.string	:gender
    	t.string	:streetAddress
    	t.string	:city
    	t.string	:postalCode
    	t.string	:homePhone
    	t.string	:cellPhone
    	t.boolean	:graduateFTStatus
    	t.boolean	:previousUTAPosition
    	t.integer	:preferredHours
    	t.integer	:maximumHours

      t.timestamps null: false
    end
  end
end