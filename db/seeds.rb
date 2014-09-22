# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
require 'faker'
100.times do
	username = Faker::Internet.user_name
	password = "password"
	firstname = Faker::Name.first_name
	lastname = Faker::Name.last_name
	email = Faker::Internet.email
	user = User.create(email: email, username: username, password: password, firstname: firstname, lastname: lastname) 
	user.save!	
end




300.times do
	user_id = rand(1..100)
	user = User.find(user_id)
	title = Faker::Lorem.sentence
	body = Faker::Lorem.paragraphs(3).join('\n')
	categories = ["news","business","sports","science","health"]
	category1 = categories[rand(0...4)]
	category2 = categories[rand(0...4)]
	category3 = categories[rand(0...4)]
	user.posts.create(title:title,body:body,category1:category1,category2:category2,category3:category3)
end

300.times do
	user_id = rand(1..100)
	post_id = rand(1..100)
	user = User.find(user_id)
	post = Post.find(post_id)
	body = Faker::Lorem.paragraphs(1).join('\n')
	comment = Comment.create(post_id:post_id, user_id:user_id, body:body)
	comment.save!
end