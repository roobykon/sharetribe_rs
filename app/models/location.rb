# == Schema Information
#
# Table name: locations
#
#  id             :integer          not null, primary key
#  latitude       :float(24)
#  longitude      :float(24)
#  address        :string(255)
#  google_address :string(255)
#  city           :string(255)
#  country        :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  listing_id     :integer
#  person_id      :string(255)
#  location_type  :string(255)
#  community_id   :integer
#
# Indexes
#
#  index_locations_on_community_id  (community_id)
#  index_locations_on_listing_id    (listing_id)
#  index_locations_on_person_id     (person_id)
#

class Location < ApplicationRecord

  belongs_to :person
  belongs_to :listing
  belongs_to :community

  before_save :search_and_fill_latlng

  def parse_supplementary_location(places)
    places["address_components"].each do |place|
      type = place["types"][0]
      @city = place["long_name"] if %w(locality neighborhood postal_town).include? type
      @country = place["long_name"] if type == "country"
    end

    [@city, @country]
  end

  def search_and_fill_latlng(address=nil, locale=APP_CONFIG.default_locale)
    okresponse = false
    geocoder = "https://maps.googleapis.com/maps/api/geocode/json?key=#{APP_CONFIG.google_maps_key}&address="

    if address == nil
      address = self.address
    end

    if address != nil && address != ""
      url = URI.escape(geocoder+address)
      resp = RestClient.get(url)
      result = JSON.parse(resp.body)

      if result["status"] == "OK"
        self.latitude = result["results"][0]["geometry"]["location"]["lat"]
        self.longitude = result["results"][0]["geometry"]["location"]["lng"]

        additional_location = parse_supplementary_location(result["results"][0])
        unless additional_location.empty?
          self.city = additional_location[0]
          self.country = additional_location[1]
        end
        okresponse = true
      end
    end
    okresponse
  end

end
