class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if params[:id].to_i == @user.id
      if @user.update(user_params)
        flash[:notice] = 'Profile changes saved successfully.'
        redirect_to user_path(@user)
      else
        flash[:error] = 'Profile changes could not be saved.'
        render 'edit'
      end
    else
      flash[:error] = 'Invalid match on ID stop trying to hack this system!'
      redirect_to user_path(@user)
    end
  end
  private
  def user_params
    params.require(:user).permit(:email, :name, :call_sign)
  end
end
