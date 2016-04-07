class Ranking < ActiveRecord::Base
  belongs_to :application

  validates_presence_of :application
  validates_uniqueness_of :application_id

end
