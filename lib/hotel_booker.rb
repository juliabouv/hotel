require 'date'
require 'pry'

require_relative 'reservation'
require_relative 'room'
require_relative 'factory'

module Hotel
  class HotelBooker
    attr_reader :rooms, :reservations
    
    # construction of all room instances moved to factory module
    def initialize
      @rooms = Hotel_Factory::rooms
      @reservations = []
    end
    
    def book_reservation(checkin_date, checkout_date, room_number: nil)
      verify_reservation_dates(checkin_date, checkout_date)
      chosen_room = choose_reservation_room(checkin_date, checkout_date, room_number: room_number)
      reservation = Hotel::Reservation.new(
        checkin_date: checkin_date,
        checkout_date: checkout_date,
        status: :IN_PROGRESS,
        room: chosen_room,
        room_number: room_number,
        block: nil
      )
      
      @reservations << reservation
      @reservations.each { |reservation| reservation.switch_status }
      
      return reservation
    end
    
    def create_hotel_block(checkin_date, checkout_date, number_of_rooms, discounted_rate)
      verify_reservation_dates(checkin_date, checkout_date)

      block = find_available_block(checkin_date, checkout_date, number_of_rooms, discounted_rate)
      reservation = Hotel::Reservation.new(
        checkin_date: checkin_date,
        checkout_date: checkout_date,
        status: :IN_PROGRESS,
        block: block,
        discounted_rate: discounted_rate
      )

      @reservations << reservation
      @reservations.each { |reservation| reservation.switch_status }
      
      return reservation
    end
    
    def find_available_block(checkin_date, checkout_date, number_of_rooms, discounted_rate)
      block = []
      @rooms.each do |room|
        block << room if room.available?(checkin_date, checkout_date)
        break if block.length == number_of_rooms
      end
      
      raise ArgumentError.new "Not enough rooms available during your requested time!" if block.length < number_of_rooms
      
      return block
    end
    
    def verify_reservation_dates(checkin_date, checkout_date)
      # raise ArgumentError for bad dates
      raise ArgumentError.new "Checkout date must be after checkin date" unless checkout_date > checkin_date
      raise ArgumentError.new "Checkin date cannot be before today" if checkin_date < Date.today
      raise ArgumentError.new "Only overnight stays allowed!" if checkin_date == checkout_date
    end
    # I can get a reservation of a room for a given date range, and that room will not be part of any other reservation overlapping that date range
    def choose_reservation_room(checkin_date, checkout_date, room_number: nil)
      room_options = list_rooms_available(checkin_date, checkout_date)
      
      if room_number
        chosen_room = find_room(room_number)
        raise ArgumentError.new "That room is already booked for that date range" unless room_options.include?(chosen_room)
      else
        chosen_room = room_options.find { |room| room }
        raise ArgumentError.new "There are no rooms available for that date range" if chosen_room == nil 
      end
      
      return chosen_room
    end
    
    def find_room(room_number)
      # grab instance of room by room number
      return @rooms.find { |room| room.number == room_number }
    end
    
    def list_reservations_by_date(date)
      # select reservations that are within the start and end date range
      return @reservations.select { |reservation| reservation.checkin_date <= date && reservation.checkout_date >= date }
    end
    
    # I can view a list of rooms that are not reserved for a given date range, so that I can see all available rooms for that day
    def list_rooms_available(start_date, end_date)
      return @rooms.select { |room| room.available?(start_date, end_date) }
    end
  end
end
