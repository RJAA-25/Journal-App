class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3, maximum: 15 }
  validates :description, presence: true, length: { minimum: 5 }
  validates :theme_color, presence: true, inclusion: { in: ["#540D6E", "#9F86C0", "#C71F37", "#E36414", "#3A5A40", "#6A994E", "#3F37C9", "#4895EF"] }
end
