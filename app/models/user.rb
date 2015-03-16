class User < ActiveRecord::Base
  has_many :jots, dependent: :destroy
  has_many :likes, through: :jots

  has_many :followers

  # has_and_belongs_many :subscriptions, class_name: "User", foreign_key: "subscriber_id"

  alias_attribute :name, :email
end
