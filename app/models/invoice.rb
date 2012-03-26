class Invoice < ActiveRecord::Base
  has_many :invoice_items, :dependent => :destroy
  has_one :customer
  scope :todays, :conditions => ['created_at >= ?', Time.now.beginning_of_day]
end