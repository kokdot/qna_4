class User < ApplicationRecord
  has_many :answers
  has_many :questions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def self.author_of?(user, answer)
    answer.user.id == user.id ? true : false
  end
end
