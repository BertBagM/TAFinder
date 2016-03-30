class Course < ActiveRecord::Base
  has_many :sections, dependent: :destroy
  belongs_to :term

  validates :subject,
    presence: true
  validates :number,
    presence: true
  validates :graduate,
    presence: true
end
