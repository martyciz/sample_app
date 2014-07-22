class UsersController < ApplicationController
	before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user, :only => :destroy
	before_filter :redirect_signed_user, :only => [:create, :new]

	def index
		@title = "All users"
		@users = User.paginate(:page => params[:page])
	end

	def show
		@user = User.find(params[:id])
		@title = @user.name
	end

	def new
		@user = User.new
		@title = "Sign up"
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			@user.password = ""
			@user.password_confirmation = ""
			@title = "Sign up"
			render 'new'
		end
	end

	def edit
		@title = "Edit user"
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated."
			redirect_to @user
		else
			@title = "Edit user"
			render 'edit'
		end
	end

	def destroy
		user = User.find(params[:id])
		if current_user?(user)
			flash[:error] = "Cannot delete own admin account!"
		else
			user.destroy
			flash[:success] = "User destroyed."
		end
		redirect_to users_url
	end

	private
		def authenticate
			deny_access unless signed_in?
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end

		def redirect_signed_user
			if signed_in?
				redirect_to(root_path)
				return
			end
		end
end
