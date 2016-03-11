class Ranking < ActiveRecord::Base
  belongs_to :application
  belongs_to :term

  validates_uniqueness_of :application_id,
    scope: :term_id
end
