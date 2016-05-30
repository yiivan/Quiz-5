class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_bid, only: :create

  def create
    bid_params = params.require(:bid).permit(:bid_price)
    bid = Bid.new bid_params
    bid.user = current_user
    bid.auction = auction
    if bid_params[:bid_price].to_i > auction.bids.all.maximum("bid_price")
      bid.save
      redirect_to auction, notice: "You have made a Bid on this Auction!"
    else
      redirect_to auction, alert: "Your bid is lower than the current price!"
    end
  end

  def index
    @bids = current_user.bids.all
  end

  private

  def authorize_bid
    redirect_to root_path unless can? :bid, auction
  end

  def auction
    @auction ||= Auction.find params[:auction_id]
  end

  def bid
    @bid ||= Bid.find params[:id]
  end
end
