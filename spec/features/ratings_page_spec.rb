require 'rails_helper'
include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name: "iso 3", brewery: brewery }
  let!(:beer2) { FactoryGirl.create :beer, name: "Karhu", brewery: brewery }
  let!(:user1) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user, username: 'Matti' }


  before :each do
    sign_in(username: 'Pekka', password: 'Foobar1')
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect {
      click_button "Create Rating"
    }.to change { Rating.count }.from(0).to(1)

    expect(user1.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it 'all are listed correctly and with correct count' do
    FactoryGirl.create(:rating, score: 10, beer: beer1, user: user1)
    FactoryGirl.create(:rating, score: 20, beer: beer2, user: user2)
    visit ratings_path
    expect(page).to have_content 'Number of ratings: 2'
    expect(page).to have_content 'iso 3'
    expect(page).to have_content 'Karhu'
  end

  it "user's page only lists user's ratings" do
    FactoryGirl.create(:rating, score: 10, beer: beer1, user: user1)
    FactoryGirl.create(:rating, score: 20, beer: beer2, user: user2)
    visit user_path(user1)
    expect(page).to have_content 'iso 3'
    expect(page).to_not have_content 'Karhu'
  end

  it "when user deletes rating it's removed from database" do
    FactoryGirl.create(:rating, score: 10, beer: beer1, user: user1)
    visit user_path(user1)
    click_link(href:"#{rating_path(user1.ratings.first)}")
    expect(user1.ratings.count).to eq(0)
  end
end