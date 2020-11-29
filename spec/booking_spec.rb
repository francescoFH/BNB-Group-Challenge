require 'booking'

describe 'booking' do

  describe '.create' do
    it 'creates a new booking' do
      owner = User.create(name: 'Mr Owner', email: 'owner@mail.com', password: 'password123')

      user = User.create(name: 'Mr User', email: 'user@mail.com', password: 'password123')

      space = Space.create(owner: owner.id, name: 'Cosy cabin',
        description: 'Escape to the countryside and relax by a log fire',
        price: 100, from_date: '2020-12-19', to_date: '2021-01-03')

      booking = Booking.create(user_id: user.id, space_id: space.id, space_name: 'Cosy cabin', booking_date: '2020-12-25', total_price: '100', booked: false)

      expect(booking.space_name).to eq 'Cosy cabin'
      expect(booking.booking_date).to eq '2020-12-25'
      expect(booking.total_price).to eq '100'
      expect(booking.booked).to eq 'f'
    end
  end
end
