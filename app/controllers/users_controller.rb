class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :update_hobbies, :destroy]
  before_action :correct_user, only: [:edit, :update, :update_hobbies]

  def index
    # @users = User.search(params[:search])
    @users = User.search(params[:search]).order("name").page(params[:page])
  end

  def show
  	@user = User.includes(:microposts, :hobbies).find(params[:id])
    @hobby = current_user.hobbies.build if logged_in?
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


  def update_hobbies
    if hobby_id.present?
      hobby = Hobby.find_by(id: hobby_id)
      @user.hobbies << hobby unless @user.hobbies.exists?(hobby[:id])
      flash[:success] = "Hobby added successfully!"
      redirect_to(@user)
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

  def hobby_id
    params[:user][:hobby_ids]
  end
end