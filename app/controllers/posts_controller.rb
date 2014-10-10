require 'dragonfly'
require 'aws-sdk'

class PostsController < ApplicationController

	def index
	end

	def create
		@post = Post.create(user_id:params[:user_id],
							title:params[:post][:title],
							body:params[:body],
							category1:params[:category1],
							category2:params[:category2],
							category3:params[:category3])
		@post.save!
		if params[:image] != nil
			@photo = Photo.new
			@photo.image_uid = Dragonfly.app.store(params[:image], path: "images/some_identifier/the_name.jpg", headers: {'x-amz-acl' => 'public-read-write'})
			@photo.post_id = @post.id
			@photo.save!
		end
		redirect_to user_path(params[:user_id])
	end

	def edit
		@post = Post.find(params[:post_id])
		@user = User.find(session[:user_id])
		category1 = @post.category1
		render layout: false
	end

	def update
		@post = Post.find(params[:id])
		@post.category1 = params[:category1]
		@post.category2 = params[:category2]
		@post.category3 = params[:category3]
		@post.title = params[:post][:title]
		@post.body = params[:body]
		@post.save!
			@user = User.find(session[:user_id])
		redirect_to user_path(@user)
	end

	def show
		@comment = Comment.new
		@user = User.find(params[:user_id])
		@post = Post.find(params[:id])
		@comments = @post.comments
	end

	def delete_post
		@post = Post.find(params[:post_id])
		@post.destroy!
    	render layout: false	
	end
end
