namespace :dev do
  task fake_post: :environment do
    Post.destroy_all
    end
end
