class AddUpcToItems < ActiveRecord::Migration
  def change
    add_column :items, :UPC, :integer

  end
end
