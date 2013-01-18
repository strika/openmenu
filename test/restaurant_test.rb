require "test/unit"
require "openmenu"

class RestaurantTest < Test::Unit::TestCase
  def test_find
    @open_menu_id = "20e54732-15bb-11e0-b40e-0018512e6b26"
    @fiorini = OpenMenu::Restaurant.find(@open_menu_id)

    assert_equal "Fiorini", @fiorini.restaurant_name
    assert_equal "209 E. 56th St.", @fiorini.address_1
    assert_equal "Manhattan", @fiorini.city
    assert_equal "NY", @fiorini.state
  end
end
