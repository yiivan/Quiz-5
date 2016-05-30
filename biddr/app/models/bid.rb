class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  # validate :cant_be_less_than_current_price

  # validate :cant_be_less_than_reserve_price

  private

  # def cant_be_less_than_current_price
  #   if self.bid_price.present? && bid_price <= self.maximum(:bid_price)
  #     errors.add(:bid_price, "The bid price has to be larger than the current price")
  #   end
  # end

  # def cant_be_less_than_reserve_price
  #   if bid_price <= auction.reserve_price
  #     errors.add(:bid_price, "The bid price has to be larger than the reserve price")
  #   end
  # end
end
