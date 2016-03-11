class Application < ActiveRecord::Base
  has_many :rankings
  has_many :terms, through: :rankings

  #validates_assocaited :terms
  validates :email,
    presence: true,
    uniqueness: true,
    length: { in: 3..50 },
    format: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i


    def self.to_csv(options = {})
	    CSV.generate do |csv|
	      csv << column_names
	      all.each do |application|
	        csv << application.attributes.values_at(*column_names)
	      end
	    end
	  end

  def full_name
    "#{firstName} #{lastName}"
  end
end
