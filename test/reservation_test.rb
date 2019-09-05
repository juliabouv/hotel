require_relative 'test_helper'

describe "Reservation" do
  before do
    room = Hotel::Room.new(
      number: 1, 
      room_cost: 200.00
    )
    @reservation = Hotel::Reservation.new(
      checkin_date: Date.today + 1,
      checkout_date: Date.today + 4,
      room: room,
      room_number: 1
    )  
  end
  describe "#initialize" do
    
    it "creates instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
    
    it "is set up for specific attributes and data types" do
      [:checkin_date, :checkout_date, :status, :room, :room_number].each do |element|
        expect(@reservation).must_respond_to element
      end
      
      expect(@reservation.checkin_date).must_be_instance_of Date
      expect(@reservation.checkout_date).must_be_instance_of Date
      expect(@reservation.room_number).must_be_kind_of Integer
      expect(@reservation.room).must_be_kind_of Hotel::Room
      p @reservation.room
    end
    
    it "creates instance with room_number, when only room included" do
      room = Hotel::Room.new(
        number: 1, 
        room_cost: 200.00
      )
      
      @reservation = Hotel::Reservation.new(
        checkin_date: Date.today + 1,
        checkout_date: Date.today + 4,
        room: room,
        room_number: nil
      )
      expect (@reservation).must_be_instance_of Hotel::Reservation
      expect (@reservation.room_number).must_equal 1
      expect (@reservation.room_number).must_be_instance_of Integer
    end
    
    it "creates instance of reservation when only room_number included" do
      room = Hotel::Room.new(
        number: 1, 
        room_cost: 200.00
      )
      
      @reservation = Hotel::Reservation.new(
        checkin_date: Date.today + 1,
        checkout_date: Date.today + 4,
        room: nil,
        room_number: 1
      )
      expect (@reservation).must_be_instance_of Hotel::Reservation
      expect (@reservation.room_number).must_equal 1
      expect (@reservation.room_number).must_be_instance_of Integer
    end
    
    it "raises an ArgumentError if no Room or room_number provided" do
      room = Hotel::Room.new(
        number: 1, 
        room_cost: 200.00
      )
      
      expect { @reservation = Hotel::Reservation.new(
        checkin_date: Date.today + 1,
        checkout_date: Date.today + 4,
        room: nil,
        room_number: nil
        )   }.must_raise ArgumentError
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
    
    describe "#switch_status" do
      before do
        @room = Hotel::Room.new(
          number: 1, 
          room_cost: 200.00
        )
      end
      it "@status is :UPCOMING in reservation is booked in the future" do
        @reservation = Hotel::Reservation.new(
          checkin_date: Date.today + 3,
          checkout_date: Date.today + 6,
          room: @room,
          room_number: 1
        )  
        @reservation.switch_status
        expect(@reservation.status).must_equal :UPCOMING
      end
      it "@status is :IN_PROGRESS when reservation is currently happening" do
        @reservation = Hotel::Reservation.new(
          checkin_date: Date.today - 1,
          checkout_date: Date.today + 2,
          room: @room,
          room_number: 1
        )  
        @reservation.switch_status
        expect(@reservation.status).must_equal :IN_PROGRESS
      end
      
      it "@status is :ENDED when reservation is over" do
        @reservation = Hotel::Reservation.new(
          checkin_date: Date.today - 4,
          checkout_date: Date.today - 2,
          room: @room,
          room_number: 1
        )  
        @reservation.switch_status
        expect(@reservation.status).must_equal :ENDED
      end
    end
  end
  
  