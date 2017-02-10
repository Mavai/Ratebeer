require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved with name and style" do
    beer = Beer.create name: "Iso 3", style: "Lager"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  describe "is not saved" do
    it "without a name" do
      beer = Beer.create name:"", style:"Lager"

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "without a style" do
      beer = Beer.create name:"Iso 3", style:""

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
