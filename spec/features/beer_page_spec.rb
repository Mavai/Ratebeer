require 'rails_helper'
include Helpers

describe 'Beer' do
  let!(:brewery) { FactoryGirl.create :brewery, name: "Koff" }
  let!(:user) { FactoryGirl.create :user }
  let!(:style) { FactoryGirl.create :style }

  before :each do
    sign_in(username: 'Pekka', password: 'Foobar1')
  end

  it 'is registered when given valid name' do
    visit beers_path
    click_link 'New Beer'
    fill_in('beer_name', with: 'Iso 3')
    expect {
      click_button "Create Beer"
    }.to change { Beer.count }.from(0).to(1)
  end

  it 'is not registered when not given valid name' do
    visit beers_path
    click_link 'New Beer'
    click_button "Create Beer"
    expect(page).to have_content "Name can't be blank"
    expect(Beer.count).to eq(0)
  end

end