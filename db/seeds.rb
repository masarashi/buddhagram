# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 20.times do |i|
#   User.find_by(email: "demouser#{i}@example.com").destroy
# end

# 20.times do |i|
#   User.create(email: "demouser#{i}@example.com",
#               name: Faker::Name.name,
#               profile: Faker::Lorem.paragraph,
#               password: "demopassword#{i}").image.attach(io: File.open("app/javascript/images/users/demouser#{i}.png"),
#                                                          filename: "demouser#{i}.png",
#                                                          content_type: 'image/png')
# end

# require 'csv'

# CSV.foreach('db/seeds/statues.csv', headers: true) do |row|
#   Statue.create(
#     name: row['name'],
#     ruby: row['ruby'],
#     grade: row['grade'],
#     content: row['content']
#   )
# end

5.times do
  images = Dir.glob('app/javascript/images/statues/*')
  post = Post.new(user_id: User.all.sample.id, content: Faker::Lorem.sentence, spot_id: Spot.all.sample.id)
  post.images.attach(io: File.open(images.sample), filename: images.sample)
  post.save
end
