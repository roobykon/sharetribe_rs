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

require 'rails_helper'

RSpec.describe FavoriteListing, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
