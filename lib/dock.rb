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

  def charge(boat_to_find)
    renter_info = {}
    boat_info = rental_log.find {|boat, renters| boat == boat_to_find}
    renter_info[:card_number] = boat_info[1].credit_card_number
      if boat_to_find.hours_rented <= 3
        renter_info[:amount] = boat_to_find.hours_rented * boat_to_find.price_per_hour
      else
        renter_info[:amount] = 3 * boat_to_find.price_per_hour
    end
    renter_info
  end
end
