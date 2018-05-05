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
  end

  task fake_post: :environment do
    Post.destroy_all
    User.all.each do |user|
      rand(3..10).times do |i|
        Post.create!(
          title: FFaker::Book.title,
          description: FFaker::Lorem.paragraph,
          user: user,
          draft: [true, false, false, false].sample,
          privacy: rand(1..3),
        )
      end
    puts "create #{user.posts.count} #{user.name}'s posts"
    end
  end

  task fake_post_categories: :environment do
    Post.all.each do |post|
      rand(1..3).times do |i|
        post.categories << Category.all.sample
      end
    end
    puts "All post have categories"
  end

  task fake_reply: :environment do
    Reply.destroy_all
    Post.where(draft: false).each do |post|
      rand(2..10).times do |i|
        Reply.create!(
          comment: FFaker::Lorem.paragraph,
          post: post,
          user: User.all.sample,
        )
      end
      puts "Post #{post.id} create #{post.replies.count} replies"
    end
  end

  task fake_all: :environment do
    system 'rails db:drop'
    system 'rails db:create'
    system 'rails db:migrate'
    system 'rails dev:fake_user'
    system 'rails db:seed'
    system 'rails dev:fake_post'
    system 'rails dev:fake_post_categories'
    system 'rails dev:fake_reply'
  end
end
