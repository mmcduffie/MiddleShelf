class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  has_one :item
end
