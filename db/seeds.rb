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

10.times do |_n|
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
  num_posts = rand(2..4)
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
all_posts = Post.all
all_users.each do |user|
  num_comments = rand(2..4)
  all_posts.shuffle[0..num_comments].each do |post|
    body = FFaker::Lorem.sentences(1)

    comment = Comment.new
    comment.user_id = user.id
    comment.post_id = post.id
    comment.body = body.join
    comment.created_at = rand(1..60 * 24).minutes.ago

    comment.save
  end
end

all_users.each do |user|
  num_follow = rand(0..all_users.length)
  all_users.shuffle[0..num_follow].each do |other|
    Follow.create!(follower: user, followee: other) if user != other
  end
end

all_users.each do |user|
  num_likes = rand(0..all_users.length)
  all_posts.shuffle[0..num_likes].each do |post|
    Like.create!(user_id: user.id, likeable_id: post.id, likeable_type: post.class)
  end
end

all_comments = Comment.all
all_users.each do |user|
  num_likes = rand(0..all_users.length)
  all_comments.shuffle[0..num_likes].each do |comment|
    Like.create!(user_id: user.id, likeable_id: comment.id, likeable_type: comment.class)
  end
end
