class AddBidPriceToBids < ActiveRecord::Migration
  def change
    add_column :bids, :bid_price, :float
  end
end
