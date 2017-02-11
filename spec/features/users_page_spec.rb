require 'rails_helper'

include Helpers

describe "User" do
  let!(:user) { FactoryGirl.create :user }  
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }


  before :each do    
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      visit signin_path
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      visit signin_path
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

    it "when signed up with good credentials, is added to the system" do
      visit signup_path
      fill_in('user_username', with:'Brian')
      fill_in('user_password', with:'Secret55')
      fill_in('user_password_confirmation', with:'Secret55')

      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end
  end

  describe "user page" do
    

    it "ratings are shown on user page" do
      @rates = [10, 10, 10, 20, 20]
      @rates.each do |rate|
        user.ratings << FactoryGirl.create(:rating, score: rate, beer:beer1, user:user)
      end
      visit user_path(user)

      expect(page).to have_content 'Has made 5 ratings'

    end    
  end
end