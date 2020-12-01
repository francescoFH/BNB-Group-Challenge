require_relative 'database_connection'

class Booking

  attr_reader :id, :space_name, :booking_date, :total_price, :name, :email

  def initialize(id:, space_name:, booking_date:, total_price:, name:, email:)
    @id = id
    @space_name = space_name
    @booking_date = booking_date
    @total_price = total_price
    @name = name
    @email = email
  end

  def self.create(space_name:, booking_date:, total_price:, name:, email:)
    booking = DatabaseConnection.query(
      "INSERT INTO bookings(space_name, booking_date, total_price, name, email)
       VALUES ('#{space_name}', '#{booking_date}', '#{total_price}', '#{name}', '#{email}')
       RETURNING id, space_name, booking_date, total_price, name, email;")

   Booking.new(
     id: booking[0]['id'], space_name: booking[0]['space_name'],
     booking_date: booking[0]['booking_date'], total_price: booking[0]['total_price'],
     name: booking[0]['name'], email: booking[0]['email'])
  end

  def self.find(id:)
    requests = DatabaseConnection.query("SELECT * FROM requests WHERE owner_id = #{id};")

    requests.map do |space|
      Booking.new(
        id: space['id'], space_name: space['space_name'],
        booking_date: space['booking_date'], total_price: space['total_price'],
        name: space['name'], email: space['email'],
        available_to: space['available_to'])
      end
  end
end
