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
		@comment = Comment.new
		@user = User.find(params[:user_id])
		@post = Post.find(params[:id])
		@comments = @post.comments
	end

	def new_comment
		p params
		if session[:user_id]
			@comment = Comment.create(user_id:session[:user_id],body:params[:body],post_id:params[:post_id])
			@comment.save!
        	 render :partial => 'comment', :object => @comment
		else
			redirect_to new_user_path()
		end
	end
end
