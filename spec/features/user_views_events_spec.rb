require 'spec_helper'

feature 'user visits main page', %{
  As a vistor instrested in the organization,
  I want to view a list of upcoming events
  So that I can attend them.
} do
  # Acceptance Criteria
  # [x] When a user visits the main page, they should see 3 or less events
  # [x] Events should be sorted from newest to oldest.
  # [x] Events older than the current date should not appear
  scenario 'main page contains only 4 or less events' do

    event_ids = []
    event_names = []

    10.times do |n|
      event = FactoryGirl.create(:event)
      event.update_attribute(:event_date, Date.today + (n + 1))
      event_ids << event.id
      event_names << event.name
    end

    visit root_path

    0.upto(2) do |n|
      expect(page.find('#event-' + event_ids[n].to_s )).to have_content event_names[n][0..20]
    end

    expect(page).to_not have_content event_names[3]
  end

  scenario 'Events should be sorted from newest to oldest' do

    event_ids = []
    event_names = []

    10.times do |n|
      event = FactoryGirl.create(:event)
      event.update_attribute(:event_date, Date.today + (n + 1))
      event_ids << event.id
      event_names << event.name
    end

    visit root_path

    expect(event_names[0][0..20]).to appear_before(event_names[1][0..20])
    expect(event_names[1][0..20]).to_not appear_before(event_names[0][0..20])
  end

  scenario 'Events should be sorted from newest to oldest' do

    event = FactoryGirl.create(:event)
    event.update_attribute(:event_date, Date.today - 1)

    visit root_path

    expect(page).to_not have_content event.event_date
  end
end
