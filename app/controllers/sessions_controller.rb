class SessionsController < ApplicationController

  def new
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      redirect_to new_user_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
