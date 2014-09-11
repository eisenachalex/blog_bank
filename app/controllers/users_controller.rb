class UsersController < ApplicationController
	protect_from_forgery
	def index

	end

	def create
		if params[:password] != params[:passwordconfirm]
			redirect_to new_user_path
		else
		@user = User.create(email:params[:user][:email],
							username:params[:user][:username],
							address:params[:user][:address],
							firstname:params[:user][:firstname],
							lastname:params[:user][:lastname],
							password:params[:user][:password]
							)
		@user.save!
		session[:user_id] = @user.id
			redirect_to user_path(@user.id)
		end
	end

	def login
	end

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id]);
		@post = Post.new
		@posts = @user.posts
		p @posts
	end


end
