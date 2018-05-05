class Reply < ApplicationRecord
  validates_presence_of :comment

  belongs_to :user, counter_cache: true
  belongs_to :post, counter_cache: true
end
