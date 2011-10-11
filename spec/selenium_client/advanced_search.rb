class AdvancedSearch
  def initialize *browser
    @browser = *browser
    @adv_search_form = "adv-search-form"
    @bathrooms = "bathrooms"
    @bedrooms = "bedrooms"
    @end_date_input = "endDateInput"
    @price_from = "priceFrom"
    @price_to = "priceTo"
    @property_type = "propertyType"
    @sleeps = "sleeps"
    @special_offers = "specialOffers"
    @start_date_input = "startDateInput"
    @themes = "themes"
    @search_key_words='searchKeywords'

    @air_conditioning = "amenity0.0"
    @beach = "location0.0"
    @children_welcome = "suitability0.0"
    @dishwasher = "amenity2.0"
    @downtown = "location2.2"
    @fishing = "leisure2.0"
    @golf = "leisure0.0"
    @internet_access = "amenity1.1"
    @lake = "location0.1"
    @long_term_renters_welcome = "suitability2.1"
    @mountain = "location0.3"
    @near_the_ocean = "location1.0"
    @non_smoking_only = "suitability2.0"
    @pet_friendly = "suitability1.1"
    @pool = "amenity1.0"
    @resort = "location1.1"
    @river = "location2.1"
    @rural = "location1.2"
    @satellite_or_cable_tv = "amenity0.1"
    @skiing = "leisure1.0"
    @suitable_for_elderly_or_infirm = "suitability1.0"
    @town = "location1.3"
    @village = "location2.0"
    @washing_machine = "amenity2.1"
    @waterfront = "location0.2"
    @wheelchair_accessible = "suitability0.1"

  end

  attr_accessor :browser, :adv_search_form, :bathrooms, :bedrooms, :end_date_input, :start_date_input, :price_from, :price_to,
                :property_type, :sleeps, :special_offers, :start_date_input, :themes,
                :air_conditioning, :beach, :children_welcome, :dishwasher,
                :downtown, :fishing, :golf, :internet_access, :lake,
                :long_term_renters_welcome, :mountain, :near_the_ocean, :non_smoking_only, :pet_friendly,
                :pool, :resort, :river, :rural, :satellite_or_cable_tv,
                :skiing, :suitable_for_elderly_or_infirm, :town, :village, :washing_machine,
                :waterfront, :wheelchair_accessible, :search_key_words

end