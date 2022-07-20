class Task < ApplicationRecord
  belongs_to :category
  validates :name, presence: true, length: { minimum: 3 }
  validates :details, presence: true, length: { minimum: 5 }
  validates :deadline, comparison: { greater_than: DateTime.now }
  validates :completed, inclusion: [true, false]
  validates :overdue, inclusion: [true, false]
end
