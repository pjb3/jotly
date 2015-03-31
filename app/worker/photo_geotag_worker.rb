class PhotoGeoTagWorker < ActiveJob::Base

  def perform(jot_id)
    jot = Jot.find(jot_id)
    if jot.photo
      jpeg = EXIFR::JPEG.new(open(jot.photo.url))
      if jpeg.gps
        jot.update(
          latitude: jpeg.gps.latitude,
          longitude: jpeg.gps.longitude,
        ) 
      end
    end
  end
end


PhotoGeoTagWorker.perform_later(jot)
