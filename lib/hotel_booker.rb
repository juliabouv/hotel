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

    def list_reservations_by_date(date)
      # select reservations that are within the start and end date range
      return @reservations.select { |reservation| reservation.checkin_date <= date && reservation.checkout_date >= date }
    end
    

    def book_reservation(checkin_date, checkout_date)
       # raise ArgumentError for bad dates
       raise ArgumentError.new "Checkout date must be after checkin date" unless checkout_date > checkin_date
       raise ArgumentError.new "Checkin date cannot be before today" if checkin_date < Date.today
       raise ArgumentError.new "Only overnight stays allowed!" if checkin_date == checkout_date
       
      reservation = Hotel::Reservation.new(
        checkin_date: checkin_date,
        checkout_date: checkout_date,
        status: :IN_PROGRESS,
        room: find_room(1)
      )
      reservation.switch_status
      @reservations << reservation
      return reservation
    end

    def find_reservations_by_room(room_number)
      # create array of reservations
      return @rooms.select { |room| room.number == room_number }
    end
    
    def find_room(room_number)
      # grab instance of room by room number
      return @rooms.select { |room| room.room_number == room_number }.first
    end

    def room_availability(date)
      # use length of reservation with start and end times to check availability

    end
    
    
    
  end
end
