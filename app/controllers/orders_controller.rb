class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_reward_level

  def new
    @order = Order.new
  end

  def create
    token = params[:order] ? params[:order][:stripe_card_token] : ""
    # this token replaces "params[:order][:stripe_card_token]" in the line below
    service = Order::CreateOrder.new(user: current_user, stripe_token: token, reward_level: @reward_level)
    if service.call
      redirect_to @reward_level.campaign, notice: "Thanks for your pledge!"
    else
      @order = service.order
      render :new
    end
  end

  private

  def find_reward_level
    @reward_level = RewardLevel.find(params[:reward_level_id])
  end

end
