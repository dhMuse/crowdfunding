require 'spec_helper'

describe Api::V1::CampaignsController do
  render_views

  describe "fetching all campaigns" do
    let!(:campaign_1) { create(:campaign) }
    let!(:campaign_2) { create(:campaign) }
    
    before do
      get :index, format: :json
    end

    specify { response.body.should include(campaign_1.title) }
    specify { response.body.should include(campaign_1.details) }
    specify { response.body.should include(campaign_2.title) }
    specify { response.body.should include(campaign_2.details) }

  end

  describe "fetching a single campaign" do
    let(:campaign) { create(:campaign) }
    before do
      get :show, id: campaign.id, format: :json
    end

    it "includes campaign's title" do
      body_json = JSON.parse(response.body)
      expect(body_json["title"]).to eq(campaign.title)
    end
  end

end