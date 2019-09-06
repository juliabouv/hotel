require_relative 'test_helper'

describe "HotelBooker" do
  describe "#initialize" do
    before do
      @hotel_booker = Hotel::HotelBooker.new
    end
    it "creates instance of Room" do
      expect(@hotel_booker).must_be_kind_of Hotel::HotelBooker
    end
    
    it "starts with array of all rooms" do
      @hotel_booker.rooms.each do |room|
        expect(room).must_be_kind_of Hotel::Room
      end
      
      expect(@hotel_booker.rooms).must_be_kind_of Array
      expect(@hotel_booker.rooms.length).must_equal 20
    end
    
    it "starts with an empty array reservations" do
      expect(@hotel_booker.reservations).must_be_kind_of Array
      expect(@hotel_booker.reservations).must_be_empty
    end
  end
  
  describe "#list_rooms" do
    before do
      @hotel_booker = Hotel::HotelBooker.new
    end
    
    it "Returns array of all rooms" do
      @hotel_booker.rooms.each do |room|
        expect(room).must_be_kind_of Hotel::Room
      end
      
      expect(@hotel_booker.rooms).must_be_kind_of Array
      expect(@hotel_booker.rooms.length).must_equal 20
    end
  end
  
  describe "#book_reservation" do
    before do
      @hotel_booker = Hotel::HotelBooker.new
    end
    
    it "adds the reservation to the @reservations array" do
      @hotel_booker.book_reservation(Date.today + 4, Date.today + 8)
      
      expect(@hotel_booker.reservations.length).must_equal 1
      @hotel_booker.reservations.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end
    end
    
    it "raises an ArgumentError if check-in date is before today" do
      expect { 
        @hotel_booker.book_reservation(Date.today - 1, Date.today)
      }.must_raise ArgumentError
      
    end
    
    it "raises an ArgumentError if check-in date is after check-out date" do
      expect { 
        @hotel_booker.book_reservation(Date.today + 2, Date.today + 1)
      }.must_raise ArgumentError
      
    end
    
    it "raises an ArgumentError if check-in date and check-out date are the same" do
      expect { 
        @hotel_booker.book_reservation(Date.today + 4, Date.today + 4)
      }.must_raise ArgumentError
      
    end
  end
  
  describe "#list_reservations_by_date" do
    before do
      @hotel_booker = Hotel::HotelBooker.new
    end
    
    it "Returns array of reservations" do
      @hotel_booker.book_reservation(Date.today + 2, Date.today + 5)
      @reservations = @hotel_booker.list_reservations_by_date(Date.today + 3)
      
      @reservations.each do |reservation|
        expect(reservation).must_be_kind_of Hotel::Reservation
      end
      expect(@reservations).must_be_kind_of Array
      expect(@reservations.length).must_equal 1
    end
    
    it "Returns reservations only for date specified" do
      @hotel_booker.book_reservation(Date.today + 2, Date.today + 5)
      @hotel_booker.book_reservation(Date.today + 8, Date.today + 12)
      @reservations = @hotel_booker.list_reservations_by_date(Date.today + 3)
      expect(@reservations.length).must_equal 1
    end
  end
  
  describe "list_rooms_available" do
    before do
      @hotel_booker = Hotel::HotelBooker.new
      @hotel_booker.book_reservation(Date.today + 2, Date.today + 5, room_number: 1)
      @hotel_booker.book_reservation(Date.today + 3, Date.today + 7, room_number: 2)
      @hotel_booker.book_reservation(Date.today + 1, Date.today + 6, room_number: 3)
    end
    
    it "Returns array of rooms" do
      rooms = @hotel_booker.list_rooms_available(Date.today + 2, Date.today + 5)
      
      rooms.each do |room|
        expect(room).must_be_kind_of Hotel::Room
      end
      expect(rooms).must_be_kind_of Array
    end
    
    it "Returns only available rooms" do
      rooms = @hotel_booker.list_rooms_available(Date.today + 2, Date.today + 5)
      expect(rooms.length).must_equal 17
    end
    
    it "Returns nil if no rooms available" do
      # Book each room for these dates (Date.today + 2, Date.today + 5)
      17.times do |index|
        @hotel_booker.book_reservation(Date.today + 2, Date.today + 5, room_number: (4 + index))
      end
      rooms = @hotel_booker.list_rooms_available(Date.today + 2, Date.today + 5)
      expect(rooms).must_be_nil
    end
  end
end
