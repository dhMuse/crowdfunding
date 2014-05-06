class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :reward_level

  attr_accessor :stripe_card_token, :card_number, :cvc, :card_month, :card_year
end
