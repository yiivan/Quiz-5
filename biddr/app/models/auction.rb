class Auction < ActiveRecord::Base
  belongs_to :user

  has_many :bids, dependent: :destroy
  has_many :bidding_users, through: :bids, source: :user

  validates :title, presence: true
  validates :details, presence: true
  validates :ends_on, presence: true
  validates :reserve_price, presence: true, numericality: {greater_than_or_equal_to: 0}

  include AASM

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :reserve_met
    state :won
    state :reserve_not_met
    state :canceled

    event :publish_auction do
      transitions from: :draft, to: :published
    end

    event :meet_reserve do
      transitions from: :published, to: :reserve_met
    end

    event :win do
      transitions from: :reserve_met, to: :won
    end

    event :does_not_meet_reserve do
      transitions from: :published, to: :reserve_not_met
    end

    event :cancel do
      transitions from: [:draft, :published], to: :canceled
    end
  end
end
