class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    redirect_to login_path, status: :see_other
  end 

  def edit
    if session[:user].to_s != params[:id].to_s
      message = "Something went wrong! This is not you!"
      redirect_to login_path, notice: message
    else
      @user = User.find(params[:id])
    end
  end

  def update
    if session[:user].to_s != params[:id].to_s
      message = "Something went wrong! This is not you!"
      redirect_to login_path, notice: message
    else
      @user = User.find(params[:id])
    end

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

private
    def user_params
      params.require(:user).permit(:name, :password)
    end

end
