def sign_up (name: 'Mr Test', email: 'testme@mail.com', password: '12345', password_confirmation: '12345')
  visit '/'
  fill_in 'name', with: name
  fill_in 'email', with: email
  fill_in 'password', with: password
  fill_in 'password confirmation', with: password_confirmation
  click_button 'Sign up'
end

def sign_in(email: 'testme@gmail.com', password: '12345')
    visit '/sessions/new'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Sign in'
end
