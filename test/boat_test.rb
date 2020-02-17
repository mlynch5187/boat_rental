require 'minitest/autorun'
require 'minitest/pride'
require './lib/boat'
require './lib/renter'

class BoatTest < MiniTest::Test

  def setup
    @kayak = Boat.new(:kayak, 20)
  end

  def test_boats_exist
    assert_instance_of Boat, @kayak
  end

  def test_boats_have_a_type
    assert_equal :kayak, @kayak.type
  end

  def test_boats_have_a_price_per_hour
    assert_equal 20, @kayak.price_per_hour
  end

  def test_boats_can_be_rented_by_the_hour
    assert_equal 0, @kayak.hours_rented

    @kayak.add_hour
    @kayak.add_hour
    @kayak.add_hour

    assert_equal 3, @kayak.hours_rented
  end
end
