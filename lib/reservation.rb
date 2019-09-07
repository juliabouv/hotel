module Hotel
  class Reservation
    attr_reader :checkin_date, :checkout_date, :status, :room, :room_number, :block
    
    def initialize(checkin_date:, checkout_date:, status: :UPCOMING, room: nil, room_number: nil, block: false)
      @checkin_date = checkin_date
      @checkout_date = checkout_date
      # requires valid status
      raise ArgumentError.new "#{status} is an invalid status" unless status == :UPCOMING || status == :IN_PROGRESS || status == :ENDED
      @status = status
      
      # requires room or room number to initiate reservation class
      if room
        @room = room
        @room_number = room.number
      elsif room_number
        @room_number = room_number
        @room = Hotel::HotelBooker.new.find_room(@room_number)
      else
        raise ArgumentError, 'Room or room number is required'
      end

      if block
        @block = block
      end

      # every time a reservation is created, it is pushed into the @reservations array within that instance of room that is part of the reservation
      connect
    end

    def connect
      @room.add_reservation(self)
    end
    
    def total_reserved_nights
      return @checkout_date - @checkin_date
    end
    
    def total_cost
      return total_reserved_nights * @room.room_cost
    end

    def list_date_range
      return (@checkin_date..@checkout_date).to_a
    end
    
    def switch_status
      if @checkin_date < Date.today && @checkout_date > Date.today
        @status = :IN_PROGRESS
      elsif @checkout_date < Date.today
        @status = :ENDED
      elsif @checkin_date > Date.today
        @status = :UPCOMING
      end
    end
    
  end
end
