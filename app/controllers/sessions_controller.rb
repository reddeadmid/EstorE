class SessionsController < ApplicationController

  def login
    @users = User.all
  end

  def create
    @user = User.find_by(name: params[:name])
    if @user.present? && (@user.password == params[:password])
      session[:user] = @user.id
      redirect_to root_path
    else
      message = "Something went wrong! Check your username and password."
      redirect_to login_path, notice: message
    end
  end

  def destroy
    session[:user] = nil
    redirect_to login_path
  end

end
