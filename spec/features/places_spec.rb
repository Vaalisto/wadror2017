require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if more than one are returned by the API, all are shown at the page" do
  	places = [ Place.new( name:"Oljenkorsi", id:1),
  				Place.new( name:"Kurvitar", id:2),
  				Place.new( name:"Pääskypub", id:3) ]
  	allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(places)

  	visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    places.each do |place|
    	expect(page).to have_content(place.name)
    end
  end

  it "if no places are found, it is notified at the page" do
  	allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return([])

  	visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end