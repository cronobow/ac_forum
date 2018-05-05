class AddCounterCacheColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :posts_count, :integer, default: 0
    add_column :users, :replies_count, :integer, default: 0
    add_column :posts, :replies_count, :integer, default: 0
    add_column :posts, :viewed_count, :integer, default: 0

    User.pluck(:id).each do |i|
      User.reset_counters(i, :posts)
      User.reset_counters(i, :replies)
    end

    Post.pluck(:id).each do |i|
      Post.reset_counters(i, :replies)
    end

  end
end
