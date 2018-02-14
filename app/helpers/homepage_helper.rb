module HomepageHelper
  def show_subcategory_list(category, current_category_id)
    category.id == current_category_id || category.children.any? do |child_category|
      child_category.id == current_category_id
    end
  end

  def with_first_listing_image(listing, &block)
    Maybe(listing)
      .listing_images
      .map { |images| images.first }[:small_3x2].each { |url|
      block.call(url)
    }
  end

  def without_listing_image(listing, &block)
    if listing.listing_images.size == 0
      block.call
    end
  end

  def format_distance(distance)
    precision = (distance < 1) ? 1 : 2
    (distance < 0.1) ? "< #{number_with_delimiter(0.1, locale: locale)}" : number_with_precision(distance, precision: precision, significant: true, locale: locale)
  end

  def capacity_title
    CustomField::PEOPLE_NAME.upcase
  end

  def categories_for_homepage
    category_items = []
    # TODO remove omitting all besides 4 ?
    @main_categories.first(4).each do |category|
      machine_name = category.url.parameterize.underscore
      category_items << { category: category,
                          title: t("categories.#{machine_name}.title"),
                          description: t("categories.#{machine_name}.description") }
    end
    category_items
  end

  def listing_liked(person, listing)
    listing_item = listing.is_a?(Listing) ? listing : Listing.find(listing)
    if listing_item && person
      listing_item.in_favorites?(person)
    else
      false
    end
  end
end