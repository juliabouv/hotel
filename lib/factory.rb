module Hotel_Factory
  def self.rooms
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

  def self.reservation(checkin_date:, checkout_date:, status:, room:, room_number:, block: nil)
    reservation = Hotel::Reservation.new(
      checkin_date: checkin_date,
      checkout_date: checkout_date,
      status: status,
      room: room,
      room_number: room_number
    )
  end

  def self.hotel_block(checkin_date:, checkout_date:, status:, block:, discounted_rate:)
    reservation = Hotel::Reservation.new(
      checkin_date: checkin_date,
      checkout_date: checkout_date,
      status: status,
      block: block,
      discounted_rate: discounted_rate
    )
  end
end
