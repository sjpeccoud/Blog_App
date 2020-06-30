class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :require_user, only: [:update, :edit]
	before_action :require_same_user, only: [:update, :edit, :destroy]

	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end

	def show
		@articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end

	def new 
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "Welcome, to the Blog #{@user.username}! You have successfully signed up."
			redirect_to articles_path
		else
			render 'new'
		end
	end

	def destroy
		@user.destroy
		flash[:notice] = "Account and all associated articles deleted"

		if current_user == @user
		session[:user_id] = nil
		redirect_to root_path
		else
			redirect_to articles_path
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:notice] = "Your account was successfully updated"
			redirect_to user_path(@user)
		else
			render 'edit'
		end
	end

	private 
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end

	def require_same_user
		if current_user != @user && !current_user.admin
			flash[:alert] = "You can only edit or delete your own account."
			redirect_to @user
		end
	end
end