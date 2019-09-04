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
  
  describe "#list_reservations_by_date" do
    before do
      @hotel_booker = Hotel::HotelBooker.new
    end
    
    it "Returns array of reservations" do
      @hotel_booker.book_reservation('2020-09-15', '2020-09-18')
      p @hotel_booker.reservations
      @reservations = @hotel_booker.list_reservations_by_date('2020-09-16')
      
      @reservations.each do |reservation|
        expect(reservation).must_be_kind_of Hotel::Reservation
      end
      expect(@reservations).must_be_kind_of Array
      expect(@reservations.length).must_equal 1
    end
    
    it "Returns reservations only for date specified" do
      @hotel_booker.book_reservation('2020-09-15', '2020-09-18')
      @hotel_booker.book_reservation('2020-09-10', '2020-09-12')
      @reservations = @hotel_booker.list_reservations_by_date('2020-09-16')
      expect(@reservations.length).must_equal 1
    end
  end
end
