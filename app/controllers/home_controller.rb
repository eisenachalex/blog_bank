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

	def about
	end

	def filter_posts
		@all_users = User.all
		@users_with_posts = {}
		@all_users.each do |user|
			if user.posts.count > 0
				@users_with_posts[user] = []
				user.posts.each do |post|
					if params[:filter]
						post_categories = [post.category1,post.category2,post.category3]
						if post_categories.include?(params[:filter])
							@users_with_posts[user] << post
						end
					elsif params[:search_term]
						if post.body.include?(params[:search_term])
							@users_with_posts[user] << post
						end
					end
				end
			end
		end
		@users_with_posts.delete_if {|k,v| v == []}
		if session[:user_id]
			@user = User.find(session[:user_id])
		end
		render layout:false;
	end
end
