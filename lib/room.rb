require_relative 'hotel_booker'

module Hotel
  class Room
    attr_reader :room_number, :room_cost, :TOTAL_ROOMS

    TOTAL_ROOMS = 20
    
    def initialize(room_number:, room_cost: 200.00)
      @room_number = room_number
      @room_cost = room_cost
    end
    
    def find_reservations_by_room(room_number)
      # create array of reservations
    end
    
  end
end
