class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.valid?
      @user.update(update_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def update_params
    params.require(:user).permit(:name)
  end
end
