class CampaignsController < ApplicationController
	before_action :authenticate_user!, except: :show

	def index
		@campaigns = current_user.campaigns
	end

	def new
		@campaign = Campaign.new
		3.times { @campaign.reward_levels.build }
	end

	def create
		service = Campaign::CreateCampaign.new(params: campaign_params, user: current_user)
		if service.call
			redirect_to service.campaign, notice: "Campaign created successfully!"
		else
			@campaign = service.campaign
			(3 - @campaign.reward_levels.length).times { @campaign.reward_levels.build }
			render :new
		end
	end

	def show
		@campaign = Campaign.friendly.find(params[:id]).decorate
		@commentable = @campaign
		@comment = Comment.new
		respond_to do |format|
			format.html { render :show }
			format.js { render :show }
		end
	end

	def publish
		@campaign = Campaign.friendly.find(params[:id])
		if @campaign.publish
			redirect_to campaigns_path, notice: "Campaign published!"
		else
			redirect_to campaigns_path, alert: "Campaign publishing failed: #{@campaign.errors.full_messages}"
		end
	end

	private

	def campaign_params
		params.require(:campaign).permit(:title, :details, :target, :end_date, :address, {reward_levels_attributes: [:title, :details, :amount, :_destroy, :id]})
	end

	# def find_campaign
	# 	@campaign = current_user.campaigns.find(params[:id])
	# end

end
