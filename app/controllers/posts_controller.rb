class PostsController < ApplicationController
	def index
	end

	def create
		p params
		p "trying that post"
		@post = Post.create(user_id:params[:user_id],
							title:params[:post][:title],
							body:params[:body],
							category1:params[:category1],
							category2:params[:category2],
							category3:params[:category3])
		@post.save!
		redirect_to user_path(params[:user_id])
	end

	def filter
		@posts = Post.all
		
	end

	def show
		@comment = Comment.new
		@user = User.find(params[:user_id])
		@post = Post.find(params[:id])
		@comments = @post.comments
	end
end
