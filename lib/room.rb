module Hotel
  class Room
    attr_reader :number, :room_cost, :reservations, :TOTAL_ROOMS
    
    TOTAL_ROOMS = 20
    
    def initialize(number:, room_cost: 200.00)
      @number = number
      @room_cost = room_cost
    end
    
    def room_availability
      
    end
    
  end
end
