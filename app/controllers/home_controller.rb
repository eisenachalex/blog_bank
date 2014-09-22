class HomeController < ApplicationController
	def index
		@all_users = User.all
		@users_with_posts = []
		@all_users.each do |user|
			if user.posts.count > 0
				@users_with_posts << user
			end
		end
		if session[:user_id]
			@user = User.find(session[:user_id])
		end
	end
	def filter_posts
		@all_users = User.all
		@users_with_posts = []
		@all_users.each do |user|
			if user.posts.count > 0
				users.posts.each do |post|
					if params[:filter] == "entertainment"
					end
				@users_with_posts << user
			end
		end
		if session[:user_id]
			@user = User.find(session[:user_id])
		end
		render layout:false;
	end
end
