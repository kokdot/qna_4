require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:answers) }
  it { should have_many(:questions) }
  
  describe 'User author_of?' do
    let(:user) {create(:user) }
    let(:user_1) {create(:user) }
    let(:question) { create(:question, user:user) }
    let(:answer) { create(:answer, user:user, question: question) }

    it 'return true if user is author of qestion' do
      expect(user.author_of?(question)).to eq true
    end

    it 'return false if user is not author of qestion' do
      expect(user_1.author_of?(question)).to eq false
    end

    it 'return true if user is author of answer' do
      expect(user.author_of?(answer)).to eq true
    end

    it 'return false if user is not author of answer' do
      expect(user_1.author_of?(answer)).to eq false
    end
  end
end
