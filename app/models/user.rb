class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  has_many :reviewed_products, through: :reviews, source: :product
  has_many :products

  validates :name, presence: true
end
