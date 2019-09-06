require_relative 'test_helper'


describe "Room" do
  describe "#initialize" do
    before do
      @room = Hotel::Room.new(number: 1, room_cost: 200.00)
    end
    it "creates instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end
    
    it "is set up for specific attributes and data types" do
      [:number, :room_cost].each do |prop|
        expect(@room).must_respond_to prop
      end
      
      expect(@room.number).must_be_kind_of Integer
      expect(@room.room_cost).must_be_kind_of Float
      expect(@room.room_cost).must_equal 200.00
    end
  end
  
  describe "#available?" do
    before do
      @room = Hotel::Room.new(number: 1, room_cost: 200.00)
      @reservation1 = Hotel::Reservation.new(
        checkin_date: Date.today + 3,
        checkout_date: Date.today + 6,
        room: @room,
        room_number: 1
      )  
    end
    it "returns false if start date and end date are inside a room's reservation checkin_date and checkout_date" do
      availability = @room.available?(Date.today + 4, Date.today + 5)

      expect(availability).must_equal false
    end
    
    it "returns false if a room's reservation checkin_date and checkout_date are inside start date and end date" do
      availability = @room.available?(Date.today + 2, Date.today + 8)

      expect(availability).must_equal false
    end
    
    it "returns false if end date and start date are the same as a room's reservation checkin_date and checkout_date" do
      availability = @room.available?(Date.today + 3, Date.today + 6)

      expect(availability).must_equal false
    end
    
    it "returns false if start date and end date overlaps with a room's reservation checkout_date" do
      availability = @room.available?(Date.today + 5, Date.today + 10)

      expect(availability).must_equal false
    end
    
    it "returns false if start date and end date overlaps with a room's reservation checkin_date" do
      availability = @room.available?(Date.today + 1, Date.today + 4)

      expect(availability).must_equal false
    end
    
    it "returns true if end date and start date are before a room's reservation checkin_date and checkout_date" do
      availability = @room.available?(Date.today + 1, Date.today + 2)

      expect(availability).must_equal true
    end

    it "returns true if end date and start date are after a room's reservation checkin_date and checkout_date" do
      availability = @room.available?(Date.today + 8, Date.today + 12)

      expect(availability).must_equal true
    end
    
    it "returns true if start_date is the same as a room's reservation checkout_date and end_date is after start_date" do
      availability = @room.available?(Date.today + 6, Date.today + 10)

      expect(availability).must_equal true
    end
    
    it "returns true if end_date is the same as a room's reservation checkin_date and start_date is before end_date" do
      availability = @room.available?(Date.today + 1, Date.today + 3)

      expect(availability).must_equal true
    end
  end
end
