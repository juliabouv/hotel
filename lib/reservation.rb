module Hotel
  class Reservation
    attr_reader :checkin_date, :checkout_date, :room, :room_number, :block, :discounted_rate
    
    def initialize(checkin_date:, checkout_date:, room: nil, room_number: nil, block: nil, discounted_rate: nil)
      @checkin_date = checkin_date
      @checkout_date = checkout_date
      
      # requires room or room number to initiate reservation class
      if room
        @room = room
        @room_number = room.number
        # every time a reservation is created, it is pushed into the @reservations array within that instance of room that is part of the reservation
        connect_single(@room)
      elsif room_number
        @room_number = room_number
        @room = Hotel::HotelBooker.new.find_room(@room_number)
        connect_single(@room)
      elsif block
        @block = block
        @discounted_rate = discounted_rate
        # all rooms in block are pushed into the @reservations array for applicable room
        connect_multiple(@block)
      else
        raise ArgumentError, 'Room, room number, or block are required'
      end
    end
    
    def connect_multiple(rooms)
      rooms.each do |room|
        room.add_reservation(self)
      end
    end
    
    def connect_single(room)
      room.add_reservation(self)
    end
    
    def total_reserved_nights
      return @checkout_date - @checkin_date
    end
    
    def total_cost
      # calculate for discount of hotel_block if true
      return total_reserved_nights * @discounted_rate if @block
      
      return total_reserved_nights * @room.room_cost
    end
    
    def list_date_range
      return (@checkin_date..@checkout_date).to_a
    end
    
    def status
      if @checkin_date < Date.today && @checkout_date > Date.today
        return :IN_PROGRESS
      elsif @checkout_date < Date.today
        return :ENDED
      elsif @checkin_date > Date.today
        return :UPCOMING
      end
    end
    
  end
end
