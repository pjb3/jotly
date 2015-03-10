class User < ActiveRecord::Base
  has_many :jots
  validates_uniqueness_of :email
end
