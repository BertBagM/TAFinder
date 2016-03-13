class Application < ActiveRecord::Base
  has_many :rankings, dependent: :destroy
  has_many :terms, through: :rankings

  #validates_assocaited :terms
  validates :student_id,
    presence: true
  validates :first_name,
    presence: true
  validates :last_name,
    presence: true
  validates :email,
    presence: true,
    length: {
      in: 3..50
    },
    format: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
  validates :faculty,
    presence: true
  validates :study_year,
    presence: true
  validates :graduate,
    inclusion: {
      in: [true, false]
    }
  validates :graduate_full_time,
    inclusion: {
      in: [true, false]
    }
  validates :gender,
    presence: true
  validates :street,
    presence: true
  validates :city,
    presence: true
  validates :postal_code,
    presence: true
  validates :home_phone,
    length: {
      is: 14
    },
    format: /\(\d{3}\) \d{3}\-\d{4}/i
  validates :cell_phone,
    length: {
      is: 14
    },
    format: /\(\d{3}\) \d{3}\-\d{4}/i
  validates :previous_ta,
    inclusion: {
      in: [true, false]
    }
  validates :preferred_hours,
    presence: true
  validates :maximum_hours,
    presence: true
  validate :validate_student_id_term_uniqueness


    def self.to_csv(options = {})
	    CSV.generate do |csv|
	      csv << column_names
	      all.each do |application|
	        csv << application.attributes.values_at(*column_names)
	      end
	    end
	  end

  def full_name
    "#{first_name} #{last_name}"
  end


  private

  def validate_student_id_term_uniqueness
    if (Application.joins(:terms).where(student_id: student_id, terms: { id: terms.pluck(:id) }).where.not(id: id).present?)
      errors.add(:student_id, "has already been used for at least one of the provided terms")
    end
  end
end
