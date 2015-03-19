class Jot < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  # , counter_cache :true
  has_attached_file :photo,
    styles: { medium: "300x300>",
      thumb: "100x100"},
    default_url: "http://placehold.it/100x100"
  validates_attachment_content_type :photo,
    content_type: /\Aimage\/.*\Z/

  geocoded_by :address

  scope :recent, -> (days=3) {
    where('created_at > ?', Time.current - days.days)
  }

  scope :has_photo, -> {
    where('photo_file_name is not null')
  }

  scope :recent_with_photos, -> {
    recent.has_photo
  }

  #after_commit :get_lat_long_from_photo, if: -> (jot) { jot.latitude.blank? }

  def similar
    self.class.where(message: message)
  end
end
