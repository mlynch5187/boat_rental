require 'minitest/autorun'
require 'minitest/pride'
require './lib/boat'
require './lib/renter'
require './lib/dock'

class DockTest < MiniTest::Test


  def setup
    @dock = Dock.new("The Rowing Dock", 3)
    @kayak_1 = Boat.new(:kayak, 20)
    @kayak_2 = Boat.new(:kayak, 20)
    @sup_1 = Boat.new(:standup_paddle_board, 15)
    @patrick = Renter.new("Patrick Star", "4242424242424242")
    @eugene = Renter.new("Eugene Crabs", "1313131313131313")
    @dock.rent(@kayak_1, @patrick)
    @dock.rent(@kayak_2, @patrick)
    @dock.rent(@sup_1, @eugene)
  end

  def test_docks_exist
    assert_instance_of Dock, @dock
  end

  def test_docks_have_a_name
    assert_equal "The Rowing Dock", @dock.name
  end

  def test_docks_have_max_rental_time
    assert_equal 3, @dock.max_rental_time
  end

  def test_rental_log_stores_boat_rentals
    assert_equal ({@kayak_1 => @patrick, @kayak_2 => @patrick, @sup_1 => @eugene}), @dock.rental_log
  end

  def test_dock_renters_can_be_charged_hourly
    @kayak_1.add_hour
    @kayak_1.add_hour
    
    assert_equal ({
      :card_number => "4242424242424242",
      :amount => 40
    }), @dock.charge(@kayak_1)
  end

  def test_renters_are_not_charged_for_rental_time_past_max_rental_hours
    @kayak_1.add_hour
    @kayak_1.add_hour
    @sup_1.add_hour
    @sup_1.add_hour
    @sup_1.add_hour
    @sup_1.add_hour
    @sup_1.add_hour

    assert_equal ({
      :card_number => "1313131313131313",
      :amount => 45
    }), @dock.charge(@sup_1)
  end
end

# Use TDD to implement a `Dock#charge` method:
#
# * This method takes a `Boat` as an argument
# * This method returns a hash with two key/value pairs:
#   * The key `:card_number` points to the credit card number of the `Renter` that rented the boat
#   * The key `:amount` points to the amount that should be charged. The amount is calculated by multiplying the Boat's price_per_hour by the number of hours it was rented. However, any hours past the Dock's max_rental_time should not be counted. So if a Boat is rented for 4 hours, and the max_rental_time is 3, the charge should only be for 3 hours.

# # Any hours past the max rental time should not count
