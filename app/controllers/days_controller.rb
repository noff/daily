class DaysController < ApplicationController

  def create
    day = Day.new(date: Date.current)
    if day.save
      redirect_to root_path, notice: "День успешно создан"
    else
      redirect_to root_path, alert: "Не удалось создать дату, возможно она уже существует"
    end
  end

end
