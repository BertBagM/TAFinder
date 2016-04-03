class Section < ActiveRecord::Base
  belongs_to :course
  has_one :term, through: :course

  validates :number,
    presence: true
  validates :act_type,
    presence: true
  validates :lab_hours,
    presence: true
  validates :marking_hours,
    presence: true
  validates :coord_hours,
    presence: true
  validates :enrolled_est,
    presence: true
  validates :enrolled,
    presence: true
  validates :released,
    presence: true
  validates :capacity,
    presence: true


  def to_s
    "#{course.to_s} #{number}"
  end

  def total_hours
    lab_hours + marking_hours + coord_hours
  end
end
