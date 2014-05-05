class UsersController < ApplicationController

	def new
		@user = User.new
		@user.build_profile # has_one
		# @user.questions.build # has_many
	end

	def create
		@user = User.new(user_params)
		respond_to do |format|
			if @user.save
				session[:user_id] = @user.id
				format.html {redirect_to root_path, notice: "Thanks for registering"}
				format.js {render}
			else
				# @user.build_profile unless @user.profile.present?
				format.html {render :new}
				format.js {render js: "alert('ERROR');"}
			end
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, {profile_attributes: [:first_name, :last_name, :address, :id]})
	end

end
