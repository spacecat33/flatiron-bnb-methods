class User < ActiveRecord::Base
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :reviews, :foreign_key => 'guest_id'
  
  def change_user_host_status
    self.host = true
  end

  def guests
    reservations.collect do |res|
      res.guest
    end
  end

  def hosts
    self.trips.collect do |res|
       res.listing.host
    end
  end

  def host_reviews
    guests.collect do |guest|
      guest.reviews
    end.flatten
  end
  
  # addcallbacks - 
  # Whenever a listing is created, the user attached to that listing should be converted into a "host". This means that the user's host field is set to true
  # Whenever a listing is destroyed (new callback! Google it!) the user attached to that listing should be converted back to a regular user. That means setting the host field to false.
end
