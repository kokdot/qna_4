class AnswersController < ApplicationController
  before_action :load_question, only: [:create]

  def create
    @answer = @question.answers.create(answer_params)
    redirect_to @question

  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Ansewr.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

end
