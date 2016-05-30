require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  before { request.session[:user_id] = user.id }

  describe "#new" do
    before { get :new }

    it "renders the new template" do
      expect(response).to render_template(:new)
    end

    it "assigns an auction object" do
      expect(assigns(:auction)).to be_a_new(Auction)
    end
  end

  describe "#create" do
    describe "with valid attributes" do
      def valid_request
        post :create, auction: FactoryGirl.attributes_for(:auction)
      end

      it "saves a record to the database" do
        count_before = Auction.count
        valid_request
        count_after = Auction.count
        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the auction's show page" do
        valid_request
        expect(response).to redirect_to(auction_path(Auction.last))
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end
  end
end
