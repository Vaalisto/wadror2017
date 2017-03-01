class BeerClub < ActiveRecord::Base	
	has_many :memberships, dependent: :destroy
	has_many :members, through: :memberships, source: :user
	
	has_many :confirmed_members, -> { where confirmed: true }, class_name: "Membership"
	has_many :unconfirmed_members, -> { where confirmed: [false, nil] }, class_name: "Membership"
end
