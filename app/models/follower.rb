class Follower < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscriber, class_name: 'User'
end
