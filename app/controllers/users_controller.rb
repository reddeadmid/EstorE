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
    if helpers.super_user? || helpers.user_match?
      @user = User.find(params[:id])
      @user.destroy
      
      redirect_to login_path, status: :see_other
    else
      message = "You can't do that."
      redirect_to login_path, notice: message
    end
  end 

  def edit
    if helpers.super_user? || helpers.user_match?
      @user = User.find(params[:id])
    else
      message = "Something went wrong! This is not you!"
      redirect_to login_path, notice: message
    end
  end

  def update
    if helpers.super_user? || helpers.user_match?
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to @user
      else
        render :edit, status: :unprocessable_entity
      end
    else
      message = "Something went wrong! This is not you!"
      redirect_to login_path, notice: message
    end
  end

  def show
    @user = User.find(params[:id])
    
    if helpers.user_match?
      @viewer = "Owner"
    else
      @viewer = @user.name.to_s
    end
  end

private
    def user_params
      params.require(:user).permit(:name, :password)
    end

end
