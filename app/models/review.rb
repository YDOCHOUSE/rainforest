class Review < ActiveRecord::Base
belongs_to :product
belongs_to :user
scope :most_recent, -> {order(created_at: :desc)}

end
