# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |i|
  User.find_by(email: "demouser#{i}@example.com").destroy
end

20.times do |i|
  User.create(email: "demouser#{i}@example.com",
              name: Faker::Name.name,
              profile: Faker::Lorem.paragraph,
              password: "demopassword#{i}").image.attach(io: File.open("app/javascript/images/users/demouser#{i}.png"),
                                                         filename: "demouser#{i}.png",
                                                         content_type: 'image/png')
end
