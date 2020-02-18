class Dock
  attr_reader :name, :max_rental_time, :rental_log

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
  end

  def rent(boat, renter)
    @rental_log[boat] = renter
  end

  def charge(boat)
    renter_info = {}
    boat_info = rental_log.find {|boat| boat == boat}
    renter_info[:card_number] = boat_info[1].credit_card_number
    renter_info[:amount] = boat.price_per_hour * boat.hours_rented
    renter_info
    # require "pry"; binding.pry
  end

end
