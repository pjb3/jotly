class User < ActiveRecord::Base
  has_many :jots
  has_many :likes
  validates_uniqueness_of :email
end
