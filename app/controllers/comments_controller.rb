class CommentsController < ApplicationController
	def create
		p params
		if session[:user_id]
			@comment = Comment.create(user_id:session[:user_id],body:params[:body],post_id:params[:post_id])
			@comment.save!
			redirect_to user_post_path(user_id:params[:user_id],id:params[:post_id])
		else
			redirect_to new_user_path()
		end
	end
end
