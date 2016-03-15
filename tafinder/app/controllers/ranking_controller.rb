class RankingController < ApplicationController
	before_action :validate_logged_in

	def update
		Ranking.find_each do |ranking|
			application = Application.find_by student_id: ranking.application_id, term_id: ranking.term_id
			score = ranking_alg(application)
			ranking.update_attributes(:position => score)
		end
  end

  private

  def ranking_alg(application)
  	score = 0
  	if ((application.faculty == "Sciences") || (application.program == "Computer Science"))
  		if (application.graduate)
  			score += 0.5
  		else
  			score += (application.study_year * 0.025)
  		end
  		if (application.graduate_full_time)
  			score += 0.1
  		end
  		if (application.gpa)
  			score += (application.gpa * 0.046)
  		end
  		if (application.previous_ta)
  			score += 0.1
  		end
  	end
  	return score
  end
end
