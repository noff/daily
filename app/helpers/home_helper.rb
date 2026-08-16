module HomeHelper

  # Можно ли менять статус задачи.
  # Для задач, которые не сегодня и не в прошлый рабочий день менять статус нельзя
  # @param [Day] day
  # @return [Boolean]
  def task_change_allowed?(day)
    !@day_current.nil? && day.id == @day_current.id || !@day_previous.nil? && day.id == @day_previous.id
  end

  def health_color(day)
    return nil if day.date === Date.current
    completed_tasks = day.tasks.where(completed: true).count
    incompleted_tasks = day.tasks.where(completed: false).count
    return "bg-success-subtle" if completed_tasks > incompleted_tasks
    return "bg-warning-subtle" if completed_tasks == incompleted_tasks
    "bg-danger-subtle"
  end
end
