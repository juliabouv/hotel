module Hotel
  class HotelBooker
    attr_reader :rooms, :reservations
    
    def initialize
      @rooms = list_rooms
      @reservations = []
    end
    
    def list_rooms
      @rooms = []
      Hotel::Room::TOTAL_ROOMS.times do |index|
          room = Hotel::Room.new(
            room_number: index + 1,
            room_cost: 200.00
          )
          @rooms << room
      end
      return @rooms
    end
    
    def list_reservations
      
    end

    def book_reservation(checkin_date, checkout_date, room)
    end

    def room_availability(date)
    end

    def total_reserved_nights
    end

    def total_cost
    end
    
  end
end
