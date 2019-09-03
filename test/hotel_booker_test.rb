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

  describe "#list_reservations" do
    before do
      @hotel_booker = Hotel::HotelBooker.new
    end
    
    it "Returns array of all rooms" do
      @hotel_booker.reservations.each do |reservation|
        expect(room).must_be_kind_of Hotel::Reservation
      end
      
      expect(@hotel_booker.rooms).must_be_kind_of Array
    end
  end
end
