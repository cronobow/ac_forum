namespace :dev do
  task fake_user: :environment do
    Reply.destroy_all
    Post.destroy_all
    User.destroy_all
    10.times do |i|
      User.create!(
        email: (User.count+1).to_s+".user@example.com",
        password:"12345678",
        name: FFaker::Name.first_name_female,
        description:FFaker::Lorem.paragraph,
        )
    end
    puts "create #{User.count} fake users"
    system('rails db:seed')
  end

  task fake_post: :environment do
    Post.destroy_all
    User.all.each do |user|
      5.times do |i|
        Post.create!(
          title: FFaker::Book.title,
          description: FFaker::Lorem.paragraph,
          user: user,
        )
      end
    puts "create #{user.posts.count} #{user.name}'s posts"
    end
  end

  task fake_reply: :environment do
    Reply.destroy_all
    Post.all.each do |post|
      5.times do |i|
        Reply.create!(
          comment: FFaker::Lorem.paragraph,
          post: post,
          user_id: rand(User.first.id.to_i..User.last.id.to_i),
        )
      end
    puts "Post #{post.id} create 5 replies"
    end
  end

  task fake_all: :environment do
    system 'rails db:reset' if Rails.env == 'development'
    system 'rails db:migrate'
    system 'rails dev:fake_user'
    system 'rails dev:fake_post'
    system 'rails dev:fake_reply'
  end
end
