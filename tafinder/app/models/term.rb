class Term < ActiveRecord::Base
  has_many :rankings
  has_many :applications, through: :rankings

  enum semester: {
    winter: "W",
    fall: "F",
    summer: "S"
  }

  validates_uniqueness_of :semester,
    scope: :year


  def to_s
    "#{year}#{semester}"
  end
end
