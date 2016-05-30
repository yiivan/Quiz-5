class AuctionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_auction, only: [:show, :edit, :update, :destroy, :publish]
  before_action :authorize_auction, only: [:edit, :update, :destroy]

  def new
    @auction = Auction.new
  end

  def create
    @auction       = Auction.new(auction_params)
    @auction.user  = current_user
    if @auction.save
      redirect_to auction_path(@auction), notice: "Auction created!"
    else
      flash[:alert] = "Auction not created!"
      render :new
    end
  end

  def show
    @bid = Bid.new
    @bids = @auction.bids.all
  end

  def index
    @auctions = Auction.all
  end

  def edit
  end

  def update
    if @auction.update auction_params
      redirect_to auction_path(@auction), notice: "Auction updated!"
    else
      render :edit
    end
  end

  def destroy
    @auction.destroy
    redirect_to auctions_path, notice: "Auction deleted!"
  end

  def publish
    @auction.publish = true
    @auction.save
    @auction.publish_auction!
    redirect_to auction_path(@auction), notice: "Auction published!"
  end

  private

  def authorize_auction
    redirect_to root_path unless can? :crud, @auction
  end

  def find_auction
    @auction = Auction.find params[:id]
  end

  def auction_params
    params.require(:auction).permit([:title, :details, :ends_on,
                                      :reserve_price, :publish])
  end
end
