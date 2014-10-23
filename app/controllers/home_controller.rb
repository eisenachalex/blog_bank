require 'twitter'

class HomeController < ApplicationController
	##populate all posts / tweets
		$users_with_posts = {}
		@all_users = User.all
		@all_users.each do |user|
			if user.posts.count > 0
				posts = []
				user.posts.each do |post|
					if post.photos.first
						url = Dragonfly.app.fetch(post.photos.first.image_uid) 
					else 
						url = nil;
					end
					new_post = {}
					new_post["type"] = post
					new_post["id"] = post.id
					new_post["url"] = url
					new_post["category1"] = post.category1
					new_post["category2"] = post.category2
					new_post["category3"] = post.category3
					new_post["title"] = post.title
					new_post["created_at"] = post.created_at
					new_post["body"] = post.body
					posts << new_post
				end
				if user.twitter_handle != ""
					handle = $client.user(user.twitter_handle).screen_name
					link = $client.user(user.twitter_handle).url
					profile_image = $client.user(user.twitter_handle).profile_image_url
					@tweets = $client.user_timeline(user.twitter_handle, count: 10)
					@tweets.each do |tweet|
						new_tweet = {}
						new_tweet["type"] = "tweet"
						new_tweet["handle"] = handle
						new_tweet["link"] = link
						new_tweet["profile_image"] = profile_image
						new_tweet["body"] = tweet.text
						new_tweet["created_at"] = tweet.created_at
						posts << new_tweet
					end
				end
				posts.sort_by! {|post| post[:created_at]}
				posts.reverse!
				$users_with_posts[user] = posts
			end
		
		end

	def index
		if session[:user_id]
			@user = User.find(session[:user_id])
		end
		@users_with_posts = $users_with_posts
	end

	def about
	end

	def filter_posts
		if params[:filter]
			@users_with_posts = {}
			$users_with_posts.each do |user,posts|
				filtered_posts = []
				posts.each do |post|
					tags = [post['category1'],post['category2'],post['category3']]
					if tags.include?(params[:filter])
						filtered_posts << post
					elsif post['type'] == "tweet" and post['body'].include? params[:filter]
						filtered_posts << post
					end
				end
				if filtered_posts.count > 0
					@users_with_posts[user] = filtered_posts
				end
			end
		elsif params[:search_term]
			@users_with_posts = {}
			$users_with_posts.each do |user,posts|
				filtered_posts = []
				posts.each do |post|
					if post['body'].include? params[:search_term]
						filtered_posts << post
					end
				end
				if filtered_posts.count > 0
					@users_with_posts[user] = filtered_posts
				end
			end
		else
			@users_with_posts = $users_with_posts
		end
		render layout:false;
	end

end
