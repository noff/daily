module HomeHelper

  # Можно ли менять статус задачи.
  # Для задач, которые не сегодня и не в прошлый рабочий день менять статус нельзя
  # @param [Day] day
  # @return [Boolean]
  def task_change_allowed?(day)
    !@day_current.nil? && day.id == @day_current.id || !@day_previous.nil? && day.id == @day_previous.id
  end
end
