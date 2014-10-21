require 'twitter'

class HomeController < ApplicationController
	def index
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = "ObeUhK4O1BrSFIzPE1DrlyjrY"
		  config.consumer_secret     = "82JFy1wOVCYymxa4sicHEp8z9fXJcLXhw46jkQ3vUnBOFpYPsy"
		  config.access_token        = "2797810283-TNS1IpLInCQmmsi77JVWwLBixgGp38ltXR0u8LG"
		  config.access_token_secret = "8UE779Xop9Gj0Np0bujnDkbmaT5PcAx6mrkXrZipYaowB"
		end
		@all_users = User.all
		
		@users_with_posts = []
		@all_users.each do |user|
			if user.posts.count > 0
				modified_user = [user]
				if user.twitter_handle
					p "add it"
					twitter_dict = {}
					twitter_dict['tweets'] = client.user_timeline(user.twitter_handle, count: 5)
					twitter_dict['twitter_handle'] = client.user(user.twitter_handle).screen_name
					twitter_dict['url'] = client.user(user.twitter_handle).url
					twitter_dict['twitter_photo'] = client.user(user.twitter_handle).profile_image_url
					modified_user << twitter_dict
				end
				@users_with_posts << modified_user
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
				user.posts.order('created_at DESC').each do |post|
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
