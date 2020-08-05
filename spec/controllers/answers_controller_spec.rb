require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) {create(:user) }
  let(:question) { create(:question, user:user) }

	before { login(user) }
  
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'save a new answer in the database' do
        expect { post :create, params: { question_id: question,  answer: attributes_for(:answer, user: user) } }.to change(question.answers, :count).by(1)
      end

      it 'control author of answer' do
        post :create, params: { question_id: question,  answer: attributes_for(:answer, user: user) }

        expect(assigns(:answer).user).to eq user
      end

      it 'redirect to question' do
        post :create, params: { question_id: question,  answer: attributes_for(:answer) }
        expect(response).to redirect_to assigns(:question)
      end
    end
    
    context 'with invalid attributes' do 
      it 'does not save the answer' do
        expect { post :create, params: { question_id: question,  answer: attributes_for(:answer, :invalid) } }.to_not change(Answer, :count)
      end

      it 'redirect to question' do
        post :create, params: { question_id: question,  answer: attributes_for(:answer) }
        expect(response).to redirect_to question
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, user: user, question: question) }
    
    context 'delete your answer' do
      before { login(user) } 
      
      it 'delete the answer' do
        expect { delete :destoy, params: { id: answer } }.to change(Answers, :count).by(-1)
      end
      it 'redirect to show' do
        delete :destoy, params: { id: answer }
        expect(response).to redirect_to question
      end
    end
    
    context 'delete not your answer' do
      let!(:user_1) { create(:user) }
      
      before { login(user_1) }

      it 'delete the answer' do
        expect { delete :destoy, params: { id: answer } }.to_not change(question.answers, :count)
      end

      it 'redirect to show' do
        delete :destoy, params: { id: answer }
        expect(response).to redirect_to question
      end
    end

  end

end
