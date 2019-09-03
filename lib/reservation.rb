

require_relative 'hotel_booker'
require_relative 'room'

module Hotel
  class Reservation
    attr_reader :checkin_date, :checkout_date, :status, :room, :room_number
    
    def initialize(checkin_date:, checkout_date:, status: :UPCOMING, room: nil, room_number: nil)
      # turn dates to Time instances
      checkin_date = Date.parse(checkin_date)    
      checkout_date = Date.parse(checkout_date) 
      @checkin_date = checkin_date
      @checkout_date = checkout_date
      # raise ArgumentError for bad dates
      raise ArgumentError.new "Checkout date must be after checkin date" unless @checkout_date > @checkin_date
      raise ArgumentError.new "Checkin date cannot be before today" if @checkin_date < Date.today

      # requires valid status
      raise ArguementError.new "#{status} is an invalid status" unless status == :UPCOMING || status == :IN_PROGRESS || status == :ENDED
      @status = status

      # requires room or room number to initiate reservation class
      if room
        @room = room
        @room_number = room.room_number
      elsif room_number
        @room_number = room.room_number
      else
        raise ArgumentError, 'Room or room number is required'
      end
      @room = room || []
    end
    
    def find_room(room_number)
      # grab instance of room by room number
    end
    
    
  end
end
