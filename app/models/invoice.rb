class Invoice < ActiveRecord::Base
  has_many :invoice_items, :dependent => :destroy
  belongs_to :customer
  scope :todays, :conditions => ['created_at >= ?', Time.now.beginning_of_day]
end