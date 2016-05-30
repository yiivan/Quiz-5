require 'rails_helper'

RSpec.describe BidsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  before { request.session[:user_id] = user.id }

  let(:auction) { FactoryGirl.create(:auction) }

  describe "#create" do
    describe "with valid attributes" do
      def valid_request
        post :create, auction_id: auction, bid: {bid_price: 10}
      end

      it "saves a record to the database" do
        count_before = Bid.count
        valid_request
        count_after = Bid.count
        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the auction's show page" do
        valid_request
        expect(response).to redirect_to(auction_path(auction))
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end
  end
end
