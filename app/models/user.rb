class User < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :tasks, through: :categories
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, uniqueness: true, length: { minimum: 4, maximum: 15 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6, maximum: 128 }
end
