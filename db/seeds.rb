require 'ffaker'
require 'down'
srand(972_943_150)
FFaker::Random.seed = 972_943_150

User.create!(name: 'chaddino',
             email: 'test@test',
             password: '123123',
             password_confirmation: '123123')

User.create!(name: 'test',
             email: 'test2@test',
             password: '123123',
             password_confirmation: '123123')

5.times do |_n|
  name  = FFaker::Name.unique.name
  email = FFaker::Internet.unique.email
  password = '123123'
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )
end

User.all.each do |user|
  num_posts = rand(1..3)
  num_posts.times do
    body = FFaker::Lorem.sentences(rand(1..5))
    title = FFaker::Lorem.sentences(1)

    post = Post.new

    post.user_id = user.id
    post.title = title.join
    post.body = body.join
    post.created_at = rand(1..60 * 24).minutes.ago

    post.image.attach(
      io: File.open(
        Rails.root.join(
          'app', 'assets', 'images', 'default_image.jpg'
        )
      ), filename: 'default_image.jpg',
      content_type: ['image/png', 'image/jpg']
    )

    post.save
  end
end

all_users = User.all
all_users.each do |user|
  num_follow = rand(0..all_users.length)
  all_users.shuffle[0..num_follow].each do |other|
    Follow.create!(follower: user, followee: other) if user != other
  end
end
