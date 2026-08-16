class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new params.require(:user).permit(:name)
    if @user.save
      redirect_to root_path, notice: "Сотрудник успешно добавлен"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update params.require(:user).permit(:name)
      redirect_to root_path, notice: "Сотрудник успешно обновлен"
    else
      render :edit, status: :unprocessable_entity
    end
  end

end
