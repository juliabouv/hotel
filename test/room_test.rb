require_relative 'test_helper'


describe "Room" do
  describe "#initialize" do
    before do
      @room = Hotel::Room.new(room_number: 1, room_cost: 200.00)
    end
    it "creates instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "is set up for specific attributes and data types" do
      [:room_number, :room_cost].each do |prop|
        expect(@room).must_respond_to prop
      end
      
      expect(@room.room_number).must_be_kind_of Integer
      expect(@room.room_cost).must_be_kind_of Float
      expect(@room.room_cost).must_equal 200.00
    end
  end
end
