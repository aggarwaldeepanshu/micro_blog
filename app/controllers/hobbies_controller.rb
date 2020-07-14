class HobbiesController < ApplicationController
	before_action :logged_in_user

	def create
		hobby = Hobby.new(hobby_params)
		debugger
		if hobby.save!
			current_user.hobbies << hobby
			flash[:success] = "Hobby created successfully!"
			redirect_to user_path(current_user)
		else
			render "users/#{current_user}"
		end
	end

	private

	def hobby_params
		params.require(:hobby).permit(:name)
	end
end
