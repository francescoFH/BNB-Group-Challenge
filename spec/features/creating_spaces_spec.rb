require 'pg'

feature 'Creating spaces' do
  scenario 'Visiting list a space page' do
    visit '/spaces/new'
    expect(page).to have_content 'List a space'
  end

  scenario 'Posting a new space on MakersBnB' do
    visit '/spaces/new'
    fill_in :name , with: 'Cosy cabin'
    fill_in :description, with: 'Escape to the countryside and relax by a log fire'
    fill_in :price, with: '100'
    fill_in :from, with: '2020-12-25'
    fill_in :to, with: '2020-12-31'
    click_button 'List my space'
    expect(page).to have_content 'Book a space'
  end
end
