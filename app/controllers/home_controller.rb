class HomeController < ApplicationController

  def index
    @day_current = Day.find_by(date: Date.current)
    @day_previous = Day.order(date: :desc).second
  end

end
