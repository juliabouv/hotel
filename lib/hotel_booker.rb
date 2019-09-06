require 'date'
require 'pry'

require_relative 'reservation'
require_relative 'room'
require_relative 'date_checker'

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
          number: index + 1,
          room_cost: 200.00
        )
        @rooms << room
      end
      return @rooms
    end
    
   
    def book_reservation(checkin_date, checkout_date, room_number: nil)
      # raise ArgumentError for bad dates
      raise ArgumentError.new "Checkout date must be after checkin date" unless checkout_date > checkin_date
      raise ArgumentError.new "Checkin date cannot be before today" if checkin_date < Date.today
      raise ArgumentError.new "Only overnight stays allowed!" if checkin_date == checkout_date
      
      room_options = list_rooms_available(checkin_date, checkout_date)
      
       # I can get a reservation of a room for a given date range, and that room will not be part of any other reservation overlapping that date range
      if room_number
        chosen_room = find_room(room_number)
        raise ArgumentError.new "That room is already booked for that date range" unless room_options.include?(chosen_room)
      else
        chosen_room = room_options.find { |room| room }
        raise ArgumentError.new "There are no rooms available for that date range" if chosen_room == nil 
      end
      
      reservation = Hotel::Reservation.new(
        checkin_date: checkin_date,
        checkout_date: checkout_date,
        status: :IN_PROGRESS,
        room: chosen_room,
        room_number: room_number
      )
      
      reservation.switch_status
      @reservations << reservation
      return reservation
    end
    
    def list_reservations_by_date(date)
      # select reservations that are within the start and end date range
      return @reservations.select { |reservation| reservation.checkin_date <= date && reservation.checkout_date >= date }
    end
    
    # probably not needed!!
    # def list_reservations_by_room(room_number)
    #   # create array of reservations
    #   return @reservations.select { |reservation| reservation.room_number == room_number }
    # end
    
    
    def find_room(room_number)
      # grab instance of room by room number
      return @rooms.find { |room| room.number == room_number }
    end
    
    # I can view a list of rooms that are not reserved for a given date range, so that I can see all available rooms for that day
    def list_rooms_available(start_date, end_date)
      return @rooms.select { |room| room.available?(start_date, end_date) }
    end
  end
end
