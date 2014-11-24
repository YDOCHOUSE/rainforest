class RenamePriceInCentsToPrice < ActiveRecord::Migration
  def change
  	rename_column :products, :price_in_cents, :price
  end
end
