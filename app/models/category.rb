class Category < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { minimum: 5, maximum: 20 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { minimum: 10 }
  validates :theme_color, presence: true
end
