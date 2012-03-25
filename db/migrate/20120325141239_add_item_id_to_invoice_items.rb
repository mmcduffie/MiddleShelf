class AddItemIdToInvoiceItems < ActiveRecord::Migration
  def change
    add_column :invoice_items, :item_id, :integer

  end
end
