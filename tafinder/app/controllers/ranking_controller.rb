class RankingController < ApplicationController
	before_action :validate_logged_in

	def update
		# Not Used - Can be removed
		Ranking.find_each do |ranking|
			application = Application.find_by id: ranking.application_id
			ranking.update_attributes(:position => application.ranking_alg())
		end
  end

end
