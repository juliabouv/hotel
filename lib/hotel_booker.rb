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
      
      
      if room_number
        chosen_room = find_room(room_number)
      else
        chosen_room = find_room(1)
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
    
    def list_reservations_by_room(room_number)
      # create array of reservations
      return @reservations.select { |reservation| reservation.room_number == room_number }
    end
    
    def find_room(room_number)
      # grab instance of room by room number
      return @rooms.find { |room| room.number == room_number }
    end
    
    def room_availability(room_number, date)
      # use length of reservation with start and end times to check availability
      room_reservations = list_reservations_by_room(room_number)
      room_reservations.list_reservations_by_date(date)
    end
  end
end
