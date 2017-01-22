class Gp < ActiveRecord::Base
	scope :nearPoints, -> (latUpper,latLower,lonUpper,lonLower) {
		where(lat: latLower..latUpper, lon: lonLower..lonUpper)
	}

	def self.findNearPoints(latitude, longitude, accuracy)
		distance = accuracy.to_f

		latUpper = latitude.to_f+distance
		latLower = latitude.to_f-distance
		lonUpper = longitude.to_f+distance
		lonLower = longitude.to_f-distance

		p latitude
		p longitude 

		return nearPoints(latUpper,latLower,lonUpper,lonLower)
	end
end
