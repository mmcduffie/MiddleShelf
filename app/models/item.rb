class Item < ActiveRecord::Base
  composed_of :cost, :class_name => "Money", :mapping => %w(cost cents)
  composed_of :selling_price, :class_name => "Money", :mapping => %w(selling_price cents)
end