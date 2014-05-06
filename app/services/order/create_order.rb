class Order::CreateOrder

  include Virtus.model

  attribute :stripe_token, String
  attribute :user, User
  attribute :reward_level, RewardLevel
  attribute :order, Order

  def call
    build_order
    begin
      create_customer unless user.stripe_customer_id
      @order.stripe_txn_id = charge_customer.id
    rescue Stripe::CardError => e
      @order.errors.add(:base, "There seems to be a problem with your card")
      return false
    end
    @order.save
  end

  private

  def build_order
    @order = Order.new
    @order.user = user
    @order.reward_level = reward_level
  end

  def create_customer
    service = Stripe::CreateCustomer.new(user: user, stripe_token: stripe_token)
    service.call
  end

  def charge_customer
    Stripe::Charge.create(
      :amount => reward_level.amount * 100,
      :currency => "cad",
      :customer => user.stripe_customer_id,
      :description => "Pledge for #{reward_level.campaign_title}")
  end

end