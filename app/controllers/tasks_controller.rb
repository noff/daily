class TasksController < ApplicationController

  before_action :fetch_user

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

  def edit
    @task = Task.find params[:id]
  end

  def update
    @task = Task.find params[:id]
    if @task.update params.require(:task).permit(:summary)
      redirect_to root_path, notice: "Задача изменена"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find params[:id]
    @task.destroy
    redirect_to root_path, notice: "Задача удалена"
  end

  private

  def fetch_user
    @user = User.find params[:user_id]
  end

end
