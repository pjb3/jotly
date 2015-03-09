class User < ActiveRecord::Base
  has_many :jots, dependent: :destroy
end
