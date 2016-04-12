class Course < ActiveRecord::Base
  has_many :sections, dependent: :destroy
  belongs_to :term

  validates :subject,
    presence: true
  validates :number,
    presence: true
  validates :graduate,
    presence: true

  def self.to_csv(options = {})
    CSV.generate do |csv|
      csv << column_names
      all.each do |course|
        csv << course.attributes.values_at(*column_names)
      end
    end
  end

  def to_s
    "#{subject} #{number}"
  end
end
