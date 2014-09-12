class PostsController < ApplicationController
	def index
	end

	def create
		p params
		p "trying that post"
		@post = Post.create(user_id:params[:user_id],
							title:params[:post][:title],
							body:params[:body])
		@post.save!
		redirect_to user_path(params[:user_id])
	end

	def filter
		@posts = Post.all
		
	end

	def show
		@user = User.find(params[:user_id])
		@post = Post.find(params[:id])
		@comments = @post.comments
	end
end
