class TasksController < ApplicationController

  before_action :fetch_user
  before_action :fetch_task, except: [:new, :create]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new params.require(:task).permit(:summary)
    @task.user_id = @user.id
    if @task.save
      redirect_to root_path, notice: "Задача добавлена"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @task.update params.require(:task).permit(:summary)
      redirect_to root_path, notice: "Задача изменена"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: "Задача удалена"
  end

  def complete
    @task.update completed: true
    redirect_to root_path
  end

  def restore
    @task.update completed: false
    redirect_to root_path
  end

  private

  def fetch_user
    @user = User.find params[:user_id]
  end

  def fetch_task
    @task = Task.find params[:id]
  end

end
