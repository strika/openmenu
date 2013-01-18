require "test/unit"
require "openmenu"

class OpenMenuTest < Test::Unit::TestCase

  def setup
    @sample = File.open(File.expand_path("test/sample16.xml")) { |f| f.read }
    @om = OpenMenu::OpenMenu.parse(@sample)
  end

  def test_open_menu_parse
    assert_equal "sample", @om.uuid
    assert_equal "2013-01-03", @om.created_date
    assert_equal 1, @om.accuracy

    assert_equal 1.6, @om.version 

    assert_equal "My Restaurant", @om.restaurant_name
    assert_equal "Sample restaurant in the OpenMenu Format.", @om.brief_description
    assert_match /Vestibulum ante/, @om.full_description
    assert_equal "independent", @om.business_type
    assert_equal "x12345", @om.location_id
    assert_equal 0, @om.mobile # 1.6
    assert_equal "-81.039833", @om.longitude
    assert_equal "33.999458", @om.latitude
    assert_equal -5.00, @om.utc_offset
    assert_equal "803 Gervais St.", @om.address_1
    assert_equal "", @om.address_2
    assert_equal "Columbia", @om.city
    assert_equal "Columbia", @om.town
    assert_equal "SC", @om.state
    assert_equal "SC", @om.province
    assert_equal "29202", @om.postal_code
    assert_equal "US", @om.country

    assert_equal "(555) 777-7777", @om.phone
    assert_equal "(555) 888-8888", @om.fax
    assert_equal "http://openmenu.com", @om.website
    assert_equal "http://openmenu.com/menu/sample", @om.url

    # environment
    assert_equal nil, @om.seating_quantity
    assert_equal 12, @om.max_group_size
    assert_equal '0', @om.smoking_allowed
    assert_equal '1', @om.takeout_available
    assert_equal '', @om.delivery_available
    assert_equal 0.0, @om.delivery.radius
    assert_equal 0.0, @om.delivery.fee
    assert_equal '', @om.catering_available
    assert_equal '', @om.reservations
    assert_equal '', @om.music_type
    assert_equal '', @om.alcohol_type
    assert_equal '0', @om.pets_allowed
    assert_equal '', @om.age_level_preference
    assert_equal '', @om.wheelchair_accessible
    assert_equal 'casual', @om.dress_code
    assert_equal 'Steakhouse', @om.cuisine_type_primary
    assert_equal '', @om.cuisine_type_secondary
    assert_equal 'outdoor', @om.seating_locations.first
    assert_equal 'USD', @om.accepted_currencies.first

    assert_equal 1, @om.operating_days.first.day_of_week
    assert_equal '11:00', @om.operating_days.first.open_time
    assert_equal '22:00', @om.operating_days.first.close_time
    assert_equal 7, @om.operating_days.size

    contact = @om.contacts.first
    assert_equal 'primary', contact.type
    assert_equal 'Chris', contact.first_name
    assert_equal 'Hanscom', contact.last_name
    assert_equal 'menu@openmenu.com', contact.email

    parent = @om.parent_company
    assert_equal '', parent.name
    assert_equal '', parent.website
    assert_equal '', parent.address_1
    assert_equal '', parent.address_2
    assert_equal '', parent.city
    assert_equal '', parent.town
    assert_equal '', parent.state
    assert_equal '', parent.province
    assert_equal '', parent.postal_code
    assert_equal '', parent.country
    assert_equal '', parent.phone
    assert_equal '', parent.fax

    assert_equal 2, @om.menus.size
  end

  def test_menu_parse
    main_menu = @om.menus.first

    # Menu info
    assert_equal 'Main Menu', main_menu.name
    assert_equal '3e5d0b48-27f2-11e1-80ac-00163eeae34c', main_menu.uid
    assert_equal 'USD', main_menu.currency
    assert_equal 'en', main_menu.language
    assert_equal '', main_menu.disabled
    assert_equal false, main_menu.disabled?
    assert_equal '', main_menu.description
    assert_equal 'gratuity added for large parties', main_menu.note

    # Duration
    assert_equal 'lunch-dinner', main_menu.duration.name
    assert_equal '11:00', main_menu.duration.start
    assert_equal '22:00', main_menu.duration.end

    # Menu groups
    group = main_menu.groups.first
    assert_equal 'Appetizers', group.name
    assert_equal '2de4ae10-27f2-11e1-80ac-00163eeae34c', group.uid
    assert_equal '', group.disabled
    assert_equal false, group.disabled?
    assert_equal '', group.description
    assert_equal '', group.note

    # Menu group items
    item = group.items.first
    assert_equal 'Coconut Shrimp', item.name
    assert_match /Crispy Coconut Shrimp/, item.description
    assert_equal 7.95, item.price

    # Options
    option = main_menu.groups[2].options.first
    assert_equal 'Dressings', option.name

    option_item = option.items.first
    assert_equal 'Italian', option_item.name
    assert_equal 1.00, option_item.additional_cost
  end

end
