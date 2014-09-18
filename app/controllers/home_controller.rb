class HomeController < ApplicationController
	def index
		session[:user_id] = nil;
		@all_posts = Post.all
		@posts = []
		if params[:filter]
			@all_posts.each do |post|
				if (post.category1 || post.category2 || post.category3) == params[:filter]
					@posts << post
				end
			end
		else
			@posts = @all_posts
		end
		if session[:user_id]
			@user = User.find(session[:user_id])
		end
	end
end
