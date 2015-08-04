class SurveyController < ApplicationController 

	def index
        @question = Question.new()
	end

end

