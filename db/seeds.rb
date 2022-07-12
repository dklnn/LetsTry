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
  nickname = FFaker::Internet.unique.user_name
  name  = FFaker::Name.name
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
    # file = Down.download('https://picsum.photos/1080/1080')
    description = FFaker::Lorem.sentences(sentence_count = rand(1..5))

    post = Post.new

    post.user_id = user.id
    post.body = description.join
    post.created_at = rand(1..60 * 24).minutes.ago

    post.save!(validate: false)
  end
end

# all_users = User.all
# all_users.each { |user|
#   num_follow = rand(0..all_users.length)
#   all_users.shuffle[0..num_follow].each{ |other|
#     if user != other
#       Follow.create!(follower: user, following: other)
#     end
#   }
# }
