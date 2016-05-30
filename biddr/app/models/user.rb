class User < ActiveRecord::Base
  has_secure_password

  has_many :auctions, dependent: :destroy

  has_many :bids, dependent: :destroy
  has_many :bidden_auctions, through: :bids, source: :auction

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, uniqueness: true, presence: true, format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}"
  end
end
