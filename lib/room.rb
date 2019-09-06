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
    
    def available?(start_date, end_date)
      @reservations.each do |reservation|
        if (start_date > reservation.checkin_date && end_date < reservation.checkout_date) || (start_date < reservation.checkin_date && end_date > reservation.checkout_date) || (start_date < reservation.checkout_date && end_date > reservation.checkout_date) || (start_date < reservation.checkin_date && end_date > reservation.checkin_date) || (start_date == reservation.checkin_date && end_date == reservation.checkout_date)
          return false
        else
          return true
        end
      end
    end
    
  end
end
