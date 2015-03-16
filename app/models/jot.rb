class Jot < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  # , counter_cache :true
  has_attached_file :photo,
    styles: { medium: "100x100>" },
    default_url: "http://placehold.it/100x100"
  validates_attachment_content_type :photo,
    content_type: /\Aimage\/.*\Z/
end
