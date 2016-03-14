class RankingController < ApplicationController
	before_action :validate_logged_in

	def create
		Application.find_each do |application|
			score = ranking_alg(application)
			ranking = Ranking.new(:application_id => application.student_id, :term_id => application.term_id,
				:position => score, :locked => false)
			ranking.save()
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
