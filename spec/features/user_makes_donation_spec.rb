require 'spec_helper'

feature 'user visits main page', %{
  As a vistor instrested in the organization,
  I want to make a donation via stripe
  So that I can support the organization.
} do
  # Acceptance Criteria
  # [x] When a user visits the main page, they should see 4 buttons to donate
  # [x] If the user makes a successful donation, they see a thank you page.
  # [x] If the user makes an unsuccessful donation, they recieve error messages
  scenario 'user sees 4 donation buttons of varying amounts' do

    visit root_path
    page.should have_css('input[value="1500"][name="amount"]')
    page.should have_css('input[value="2500"][name="amount"]')
    page.should have_css('input[value="5000"][name="amount"]')
    page.should have_css('input[value="10000"][name="amount"]')
  end

  scenario 'user makes a successful donation', js: true do

    visit root_path
    first(".stripe-button-el").click
    Capybara.within_frame 'stripe_checkout_app' do
      fill_in 'email', with: 'example7864@example.com'
      fill_in 'Name',  with: 'Nick Cox'
      fill_in 'Address', with: '123 Anywhere St.'
      fill_in 'ZIP', with: '02379'
      click_button 'Payment Info'
      fill_in 'Card number', with: '4242424242424242'
      find_field('Card number').native.send_keys("4242")
      find_field('Card number').native.send_keys("4242")
      find_field('Card number').native.send_keys("4242")
      fill_in 'cc-exp', with: '222'
      find_field('MM / YY').native.send_keys("2")
      fill_in 'cc-csc', with: '222'
      click_button 'Pay'
    end

    expect(page).to have_content("Thanks")
  end
end
