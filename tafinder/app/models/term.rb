class Term < ActiveRecord::Base
  has_many :rankings, dependent: :nullify, through: :applications
  has_many :applications, dependent: :destroy
  has_many :courses, dependent: :nullify

  enum semester: {
    fallWinter: "F/W",
    springSummer: "S/S"
  }

  validates :semester,
    presence: true,
    uniqueness: {
      scope: :year,
      message: "only happens once per year"
    }
  validates :year,
    presence: true,
    format: {
      with: /(19|20)\d{2}/i,
      message: "should be a four-digit year"
    }
  validate :validate_year_range


  def to_s
    "#{year}#{semester[0].capitalize}"
  end

  def semester_index
    if (fallWinter?)
      1
    elsif (springSummer?)
      2
    else
      -1
    end
  end


  private

  def validate_year_range
    if (!year.to_i.in?(1900..Date.today.year + 5))
      errors.add(:year, "must be between 1900 and #{Date.today.year + 5}")
    end
  end
end
