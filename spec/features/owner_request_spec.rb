feature 'Display requests for owner' do
  scenario 'as an owner, I want to see a requests before I confirm it' do
    sign_up
    visit '/spaces/:id/booking'
    fill_in :booking_date, with: '2020-12-25'
    click_button 'Book'
    expect(page).to have_button 'Requests'
  end

  scenario 'as an owner, I want to see all the requests' do
    sign_up
    click_button 'Requests'
    expect(page).to have_content 'House_test from Mr Test email: test@email.com'
  end
end
