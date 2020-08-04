class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create, :destroy]
  before_action :load_answer, only: [:destroy]

	def create
		# @question
    # @answer = @question.answers.create(answer_params)
		@answer = @question.answers.new(answer_params)
    @answer.user = current_user
		if @answer.save
			redirect_to @question, notice: 'Your answer successfully created.'
		else
			render 'questions/show'
		end
  end
  
  def destroy
    if User.author_of?(current_user, @answer)
      @answer.destroy
      redirect_to @question, notice: 'Your answer successfully destroyed.'
    else
      redirect_to @question, notice: "Your can destroy only your answer."
    end
  end
	
  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

end
