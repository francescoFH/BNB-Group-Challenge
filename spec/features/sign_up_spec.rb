feature 'Sign up' do
  scenario 'As a user, I want to sign-up for MakersBnB' do
    sign_up

    expect(page).to have_content 'Book a space'
  end
end
