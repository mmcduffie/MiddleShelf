class AddSellingPriceToItem < ActiveRecord::Migration
  def change
    add_column :items, :selling_price, :integer

  end
end
