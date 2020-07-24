class AddQestionToAnswers < ActiveRecord::Migration[6.0]
  def change
  	add_reference :answers, :question, null: false, foring_key: true
  end
end
