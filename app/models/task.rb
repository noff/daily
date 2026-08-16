class Task < ApplicationRecord
  belongs_to :day
  belongs_to :user
  validates :summary, presence: true
end
