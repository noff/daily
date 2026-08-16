class Task < ApplicationRecord
  belongs_to :day
  belongs_to :user
  validates :summary, presence: true
  before_validation :set_day

  private

  def set_day
    self.day = Day.find_or_create_by(date: Date.today) if self.day.nil?
  end
end
