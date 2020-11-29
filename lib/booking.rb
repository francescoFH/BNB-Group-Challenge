require_relative 'database_connection'

class Booking

  attr_reader :id, :user_id, :space_id, :space_name, :total_price, :booking_date, :booked

  def initialize(id:, user_id:, space_id:, space_name:, total_price:, booking_date:, booked: false)
    @id = id
    @user_id = user_id
    @space_id = space_id
    @space_name = space_name
    @total_price = total_price
    @booking_date = booking_date
    @booked = booked
  end

  def self.create(booking_date:, booked:, space_id:, user_id:, space_name:, total_price:)
    booking = DatabaseConnection.query(
      "INSERT INTO bookings (booking_date, booked, space_id, user_id, space_name, total_price)
       VALUES ('#{booking_date}', '#{booked}', #{space_id}, '#{user_id}', '#{space_name}', '#{total_price}')
       RETURNING id, booking_date, booked, space_id, user_id, space_name, total_price;")

   Booking.new(
     id: booking[0]['id'], booking_date: booking[0]['booking_date'],
     booked: booking[0]['booked'], space_id: booking[0]['space_id'],
     user_id: booking[0]['user_id'], space_name: booking[0]['space_name'],
     total_price: booking[0]['total_price'])
  end
end
