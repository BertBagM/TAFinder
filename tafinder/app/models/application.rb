class Application < ActiveRecord::Base
  has_one :ranking, dependent: :destroy
  has_many :preferred_courses, dependent: :destroy
  belongs_to :term
  after_create :create_ranking
  after_update :update_ranking

  validates :student_id,
    presence: true,
    length: {
      is: 8
    }
  validates :first_name,
    presence: true,
    length: {
      in: 1..255
    }
  validates :last_name,
    presence: true,
    length: {
      in: 1..255
    }
  validates :email,
    presence: true,
    length: {
      in: 3..255
    },
    format: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
  validates :gpa,
    inclusion: {
      in: 0.0..4.33
    }
  validates :faculty,
    presence: true,
    length: {
      in: 1..255
    }
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
    presence: true,
    length: {
      in: 1..255
    }
  validates :city,
    presence: true,
    length: {
      in: 1..255
    }
  validates :postal_code,
    presence: true,
    length: {
      in: 1..255
    }
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
    presence: true,
    inclusion: {
      in: 2..12,
      message: "must be greater than 2 and less than 12"
    }
  validates :maximum_hours,
    presence: true,
    inclusion: {
      in: 2..12,
      message: "must be greater than 2 and less than 12"
    }
  validate :validate_student_id_term_uniqueness
  validate :validate_preferred_hours_less_or_equal_maximum_hours


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

  def create_ranking
    ranking = Ranking.new(application_id: self.id, position: :ranking_alg)
    ranking.save()
  end

  def update_ranking
    ranking = Ranking.find_by(application_id: self.id)
    ranking.update_attributes(:position => :ranking_alg)
  end

  def self.ranking_alg
    score = 0
    if ((self.faculty == "Sciences") || (self.program == "Computer Science"))
      if (self.graduate)
        score += 0.5
      else
        score += (self.study_year * 0.025)
      end
      if (self.graduate_full_time)
        score += 0.1
      end
      if (self.gpa)
        score += (self.gpa * 0.046)
      end
      if (self.previous_ta)
        score += 0.1
      end
    end
    return score
  end


  private

  def validate_student_id_term_uniqueness
    if (Application.joins(:term).where(student_id: student_id, terms: { id: term_id }).where.not(id: id).present?)
      errors.add(:student_id, "has already been used for this term, please contact administration for help")
    end
  end

  def validate_preferred_hours_less_or_equal_maximum_hours
    if (preferred_hours > maximum_hours)
      errors.add(:preferred_hours, "must be less than maximum hours (#{maximum_hours})")
    end
  end
end
