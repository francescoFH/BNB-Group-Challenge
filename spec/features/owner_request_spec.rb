feature 'Display requests for owner' do
  scenario 'As an owner, I want to see a requests before I confirm it' do
    sign_up
    visit '/spaces/booking'
    click_button 'Book'
    expect(page).to have_button 'Requests'
  end
end
