class BeerClub < ActiveRecord::Base
  has_many :confirmed_memberships, -> { where confirmed: true }, class_name: 'Membership'
  has_many :confirmed_users, through: :confirmed_memberships, source: :user
  has_many :unconfirmed_memberships, -> { where confirmed: false }, class_name: 'Membership'
  has_many :unconfirmed_users, through: :unconfirmed_memberships, source: :user
  has_many :memberships
  has_many :users, through: :memberships
end
