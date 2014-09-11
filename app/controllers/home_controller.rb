class HomeController < ApplicationController
	def index
		@posts = Post.all
		if session[:user_id]
			@user = User.find(session[:user_id])
		end
	end
end
