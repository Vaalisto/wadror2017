require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "beer is saved with name and style" do
  	beer = Beer.create name:"Kuohuva 3", style:"Lager"

  	expect(beer).to be_valid
  	expect(Beer.count).to eq(1)
  end

  it "beer is not saved without a name" do
  	beer = Beer.create style:"lager"

  	expect(beer).not_to be_valid
  	expect(Beer.count).to eq(0)
  end

  it "beer is not saved without a style" do
  	beer = Beer.create name:"Kuohuva 3"

  	expect(beer).not_to be_valid
  	expect(Beer.count).to eq(0)
  end
end
