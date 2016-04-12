class Course < ActiveRecord::Base
  has_many :sections, dependent: :destroy
  belongs_to :term

  validates :subject,
    presence: true,
    length: {
      is: 4
    }
  validates :number,
    presence: true,
    length: {
      is: 3
    }
  validates :graduate,
    presence: true,
    length: {
      is: 1
    }


  def to_s
    "#{subject} #{number}"
  end
end
