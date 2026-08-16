class HomeController < ApplicationController

  def index
    @day_current = Day.find_by(date: Date.current)
    @day_previous = Day.where.not(date: Date.current).order(date: :desc).first
  end

end
