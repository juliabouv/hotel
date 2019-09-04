require_relative 'test_helper'

describe "Reservation" do
  before do
    room = Hotel::Room.new(
      room_number: 1, 
      room_cost: 200.00
    )
    @reservation = Hotel::Reservation.new(
      checkin_date: '2019-09-15',
      checkout_date: '2019-09-18',
      room: room,
      room_number: 1
    )  
  end
  describe "#initialize" do
    
    it "creates instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
    
    it "is set up for specific attributes and data types" do
      [:checkin_date, :checkout_date, :status, :room, :room_number].each do |prop|
        expect(@reservation).must_respond_to prop
      end
      
      expect(@reservation.checkin_date).must_be_instance_of Date
      expect(@reservation.checkout_date).must_be_instance_of Date
      expect(@reservation.room_number).must_be_kind_of Integer
      expect(@reservation.room).must_be_kind_of Hotel::Room
      p @reservation.room
    end
  end
  
  describe "#total_reserved_nights" do
    it "calculates accurate number of nights" do
      expect(@reservation.total_reserved_nights).must_equal 3
    end
  end

  describe "#total_cost" do
    it "calculates accurate total cost" do
      cost = @reservation.room.room_cost * 3
      
      expect(@reservation.total_cost).must_equal cost
      expect(@reservation.total_cost).must_equal 200.00 * 3
    end
  end
end
