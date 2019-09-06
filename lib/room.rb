module Hotel
  class Room
    attr_reader :number, :room_cost, :reservations
    
    TOTAL_ROOMS = 20
    
    def initialize(number:, room_cost: 200.00, reservations: nil)
      @number = number
      @room_cost = room_cost
      @reservations = reservations || []
    end
    
    def add_reservation(reservation)
      @reservations << reservation
    end

  end
end
