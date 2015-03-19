class User < ActiveRecord::Base
  has_many :jots
  has_many :likes
  has_many :followers
  has_many :subscriptions, class_name: 'Follower', foreign_key: 'subscriber_id'
  has_many :subscribers, through: :followers

  validates_uniqueness_of :email

  def following_jots
    Jot.joins(:user => :subscriptions).where('followers.user_id = ?', id)
  end
end
