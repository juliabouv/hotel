module Hotel
  class Room
    attr_reader :number, :room_cost, :reservations
    
    TOTAL_ROOMS = 20
    
    def initialize(number:, room_cost: 200.00, reservations: [])
      @number = number
      @room_cost = room_cost
      @reservations = reservations || []
    end
    
    def add_reservation(reservation)
      @reservations << reservation
    end
    
    def available?(start_date, end_date)
      date_range = (start_date..(end_date-1)).to_a
      @reservations.each do |reservation|
        # compares both date ranges for overlapping dates. Will return false if overlapping dates
        # exception for start_date being the same as a reservation checkout_date
        return (date_range & reservation.list_date_range).empty? || start_date == reservation.list_date_range.last
      end
    end
    
  end
end
