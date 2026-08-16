class Day < ApplicationRecord
  has_many :tasks
  validates :date, presence: true, uniqueness: true
  validate :date_must_be_today

  private

  def date_must_be_today
    return if date.blank?
    errors.add(:date, "must be today's date") if date != Date.current
  end
end
