require 'net/http'
require 'openmenu'

module OpenMenu
  class Api
    def self.get_restaurant(id)
      uri = URI.parse("http://openmenu.com/menu/#{id}")
      response = Net::HTTP.get(uri)
      OpenMenu.parse(response)
    end
  end
end
