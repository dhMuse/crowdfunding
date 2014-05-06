class Stripe::CreateCustomer

  include Virtus.model

  attribute :user, User
  attribute :stripe_token, String

  def call
    customer = Stripe::Customer.create(
      card: stripe_token,
      description: default_description
    )
    
    user.stripe_customer_id = customer.id
    user.stripe_card_last4 = customer.cards.data[0].last4
    user.stripe_card_type = customer.cards.data[0].type
    user.save
  end

  private

  def default_description
    "Customer for #{user.email} | id: #{user.id}"
  end

end