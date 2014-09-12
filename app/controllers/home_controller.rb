class HomeController < ApplicationController
	def index
		session[:user_id] = nil
		@posts = Post.all
		if session[:user_id]
			@user = User.find(session[:user_id])
		end
	end
end
