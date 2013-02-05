require 'net/http'
require 'openmenu'

module OpenMenu
  class Restaurant
    def self.find(id)
      uri = URI.parse("http://openmenu.com/menu/#{id}")
      response = Net::HTTP.get(uri).to_s
      OpenMenu.parse(response)
    end
  end
end
