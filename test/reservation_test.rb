require_relative 'test_helper'

describe "Reservation" do
  describe "#initialize" do
    before do
      room = Hotel::Room.new(
        room_number: 1, 
        room_cost: 200.00
      )
      checkin_date = '2019-09-20'
      checkout_date = '2019-09-23'
      @reservation = Hotel::Reservation.new(
        checkin_date: checkin_date,
        checkout_date: checkout_date,
        room: room,
        room_number: 1
        )

    end
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
    end
  end
end
