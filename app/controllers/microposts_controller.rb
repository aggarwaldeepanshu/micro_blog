class MicropostsController < ApplicationController
	before_action :logged_in_user, only: [:index, :create, :destroy]
	before_action :find_micropost, only: [:destroy]

	def index
		@user = User.find(params[:user_id])
		@microposts = @user.microposts
	end

	def create
		micropost = current_user.microposts.build(micropost_params)

		if(micropost.save)
			flash[:success] = 'Micropost created!'
			redirect_to user_path(current_user)
		else
			render 'static_pages/home'
		end
	end

	def destroy
		@micropost.destroy
		flash[:success] = "Micropost deleted!"
		redirect_to user_microposts_path(current_user)
	end

	private

	def micropost_params
		params.require(:micropost).permit(:content)
	end

	def find_micropost
		@micropost = current_user.microposts.find(params[:id])
		redirect_to root_path if @micropost.nil?
	end
end
