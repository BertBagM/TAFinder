class PreferredCourse < ActiveRecord::Base
  belongs_to :application
  belongs_to :course

  validates_presence_of :application, :course
  validates_uniqueness_of :course_id,
    scope: :application_id
end
