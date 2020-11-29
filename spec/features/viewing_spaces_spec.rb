require 'pg'

feature 'View spaces' do
  scenario 'User can see all spaces for hire' do
    owner = User.create(name: 'Tester', email: 'test@gmail.com', password: 'password1234')

    Space.create(owner: owner.id, name: 'Cosy cabin',
      description: 'Escape to the countryside and relax by a log fire',
      price: 100, from_date: '2020-12-19', to_date: '2021-01-03')
    Space.create(owner: owner.id, name: 'London loft',
      description: 'Live la vida loca',
      price: 200, from_date: '2021-01-29', to_date: '2021-02-03')

    visit '/spaces'
    expect(page).to have_content('Cosy cabin')
    expect(page).to have_content('London loft')
  end
end
