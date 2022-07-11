class Task < ApplicationRecord
  belongs_to :category
  validates :name, presence: true, length: { minimum: 4 }
  validates :details, presence: true
  validates :deadline, comparison: { greater_than: DateTime.now }
  validates :completed, inclusion: [true, false]
  validates :overdue, inclusion: [true, false]
end
