class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.integer :invoice_id
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
