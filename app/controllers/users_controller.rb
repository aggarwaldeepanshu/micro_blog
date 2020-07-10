class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.search(params[:search])
  end

  def show
  	@user = User.includes(:microposts).find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if(@user.save)
      log_in @user
  		flash[:success] = "Welcome to the MicroBlog" + " #{@user.name}\n"
  		redirect_to user_path(@user)
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile Updated Successfully"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted successfully"
    redirect_to users_path
  end


  private

  def user_params
  	params.require(:user).permit(:name, :email, :email_confirmation, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end
end
