# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require './db/seeds/spots.rb'
# require './db/seeds/statues.rb'
# require './db/seeds/storehouses.rb'
# require './db/seeds/images.rb'

# ユーザ作成
# 20.times do |i|
#   User.create(email: "demouser#{i}@example.com",
#               name: Faker::Name.name,
#               profile: Faker::Lorem.paragraph,
#               password: "demopassword#{i}").image.attach(io: File.open("app/javascript/images/users/demouser#{i}.png"),
#                                                          filename: "demouser#{i}.png",
#                                                          content_type: 'image/png')
# end

# 投稿作成
# 99.times do
#   images = Dir.glob('app/javascript/images/statues/*')
#   post = Post.new(user_id: User.all.sample.id, content: Faker::Lorem.sentence, spot_id: Spot.all.sample.id)
#   post.images.attach(io: File.open(images.sample), filename: images.sample)
#   post.save
# end

# ユーザフォロー
# 20.times do |i|
#   user = User.find_by(email: "demouser#{i}@example.com")
#   other_users = User.where.not(user_id: user.id).sample(5)
#   other_users.each do |other_user|
#     user.following << other_user
#   end
# end

# いいね
# 20.times do |i|
#   user = User.find_by(email: "demouser#{i}@example.com")
#   posts = Post.where.not(user_id: user.id).sample(20)
#   posts.each do |post|
#     user.likes.create(post_id: post.id)
#   end
# end

# コメント
# 200.times do
#   user = User.all.sample
#   post = Post.where.not(user_id: user.id).sample
#   post.comments.create(user_id: user.id, content: Faker::Lorem.sentence)
# end
