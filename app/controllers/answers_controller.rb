class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:destroy]

	def create
		@answer = @question.answers.new(answer_params)
    @answer.user = current_user
		if @answer.save
			redirect_to @question, notice: 'Your answer successfully created.'
		else
			render 'questions/show'
		end
  end
  
  def destroy
    @question = @answer.question
    if current_user.author_of?(@answer)
      @answer.destroy
      redirect_to @question, notice: 'Your answer successfully destroyed.'
    else
      redirect_to @question, notice: "Your can destroy only your answer."
    end
  end
	
  private
  
  def load_answer
    @answer = Answer.find(params[:id])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

end
