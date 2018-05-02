namespace :dev do
  task fake_post: :environment do
    Post.destroy_all
    12.times do |i|
      Post.create!(
        title: ,
        descriptione: ,
        )
    end
end
