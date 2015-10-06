require 'spec_helper'

feature 'user visits main page', %{
  As a vistor instrested in the organization,
  I want to view a list of articles
  So that I can read about the organization.
} do
  # Acceptance Criteria
  # [] When a user visits the main page, they should see 4 or less articles
  # [] Articles should be sorted from newest to oldest.
  scenario 'main page contains only 4 or less articles' do

    article_ids = []
    article_titles = []

    10.times do |n|
      article = FactoryGirl.create(:article)
      article.update_attribute(:created_at, Date.today - n)
      article_ids << article.id
      article_titles << article.title
    end

    visit root_path

    0.upto(3) do |n|
      expect(page.find('#blogpost-' + article_ids[n].to_s )).to have_content article_titles[n]
    end

    expect(page).to_not have_content article_titles[4]
  end

  scenario 'articles on main page should be sorted from newest to oldest' do

    article_ids = []
    article_titles = []

    10.times do |n|
      article = FactoryGirl.create(:article)
      article.update_attribute(:created_at, Date.today - n)
      article_ids << article.id
      article_titles << article.title
    end

    visit root_path

    expect(article_titles[0]).to appear_before(article_titles[1])
    expect(article_titles[1]).to_not appear_before(article_titles[0])
  end
end
