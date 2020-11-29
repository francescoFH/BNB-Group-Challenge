require 'space'

describe Space do

  describe '.create' do
    it 'creates a new space' do
      owner = User.create(name: 'Tester', email: 'test@gmail.com', password: 'password1234')

      space = Space.create(owner: owner.id, name: 'Cosy cabin',
        description: 'Escape to the countryside and relax by a log fire',
        price: 100, from_date: '2020-12-19', to_date: '2021-01-03')

      expect(space.name).to eq 'Cosy cabin'
      expect(space.owner).to eq owner.id
      expect(space.description).to eq 'Escape to the countryside and relax by a log fire'
      expect(space.price).to eq '100'
      expect(space.from_date).to eq '2020-12-19'
      expect(space.to_date).to eq '2021-01-03'
    end
  end

  describe '.all' do
    it 'lists all the spaces' do
      owner = User.create(name: 'Tester', email: 'test@gmail.com', password: 'password1234')

      space = Space.create(owner: owner.id, name: 'Cosy cabin',
        description: 'Escape to the countryside and relax by a log fire',
        price: 100, from_date: '2020-12-19', to_date: '2021-01-03')
      Space.create(owner: owner.id, name: 'London loft',
        description: 'Live la vida loca',
        price: 200, from_date: '2021-01-29', to_date: '2021-02-03')

      spaces = Space.all

      expect(spaces.length).to eq 2
      expect(spaces.first).to be_a Space
      expect(spaces.first.name).to eq 'Cosy cabin'
      expect(spaces.last.name).to eq 'London loft'
      expect(spaces.first.id).to eq space.id
    end
  end

  describe '.available' do
    it 'gives available spaces' do
      owner = User.create(name: 'Tester', email: 'test@gmail.com', password: 'password1234')

      space = Space.create(owner: owner.id, name: 'Some house',
        description: 'Some house somewhere',
        price: 100, from_date: '2020-12-20', to_date: '2020-12-31')

      Space.create(owner: owner.id, name: 'Some house2',
        description: 'Some house2 somewhere',
        price: 100, from_date: '2020-12-25', to_date: '2020-12-29')

      Space.create(owner: owner.id, name: 'Some house3',
        description: 'Some house3 somewhere',
        price: 100, from_date: '2020-12-18', to_date: '2020-12-22')

      expect(Space.available('2020-12-20', '2020-12-31').length).to eq 2
      expect(Space.available('2020-12-25', '2020-12-31').first.name).to eq 'Some house2'
      expect(Space.available('2020-12-20', '2020-12-31').first.name).not_to eq 'Some house3'
    end
  end
end
