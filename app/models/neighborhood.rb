class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings
  
  include Reservable
  extend Reservable::ClassMethods
  # The same class/instance methods as your City object. Maybe there is a way they can share code?!?!?
  # instance methods


  def neighborhood_openings(begin_date, end_date)
    self.listings.collect do |listing|
      if !listing.listing_reserved?(begin_date, end_date)
        listing
      end
    end
  end

end
