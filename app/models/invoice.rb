class Invoice < ActiveRecord::Base
  has_many :invoice_items, :dependent => :destroy
	has_one :customer
end
