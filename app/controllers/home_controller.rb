class HomeController < ApplicationController
  def index
  	@campaigns = Campaign.published.paginate(page: params[:page], per_page: 6).order("created_at DESC")
  	respond_to do |format|
  		format.html { render :index }
  		format.js { render :index }
  	end
  end
end
