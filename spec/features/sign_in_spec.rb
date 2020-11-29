feature 'Sign in' do
  scenario 'As a user, I want to sign-in for MakersBnB' do
    User.create(name: 'Mr Test', email: 'testme@gmail.com', password: '12345')
    # sign_up
    sign_in

    expect(page).to have_content 'Welcome to MakersBNB, Mr Test!'
  end

  scenario 'User sees error if they get their email wrong' do
    sign_up

    visit '/sessions/new'
    fill_in :email, with: 'wrong@mail.com'
    fill_in :password, with: '12345'
    click_button 'Sign in'

    expect(page).not_to have_content 'Welcome, Tester'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'User sees an error if they get their password wrong' do
    sign_up

    visit '/sessions/new'
    fill_in :email, with: 'test@mail.com'
    fill_in :password, with: '54321'
    click_button 'Sign in'

    expect(page).not_to have_content 'Welcome, Tester'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'User can sign out' do
    # User.create(name: 'Tester', email: 'test@gmail.com', password: 'password1234')
    sign_up
    sign_in
    click_button 'Sign out'

    expect(page).not_to have_content 'Welcome, Tester'
    expect(page).to have_content 'You have signed out.'
  end
end
