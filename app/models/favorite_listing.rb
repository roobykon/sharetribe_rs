# == Schema Information
#
# Table name: favorite_listings
#
#  id         :integer          not null, primary key
#  listing_id :integer          not null
#  person_id  :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_favorite_listings_on_listing_id_and_person_id  (listing_id,person_id)
#

class FavoriteListing < ApplicationRecord
  belongs_to :listing
  belongs_to :person
end
