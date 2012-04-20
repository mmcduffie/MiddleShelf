$ ->
  #Classes
  class InvoiceItem extends Backbone.Model
    url:      '/invoice_items'

  class InvoiceItems extends Backbone.Collection
    model:    InvoiceItem
    url:      '/invoice_items'
  #Bind Callbacks To Buttons
  $('#add_part_button').click ->
    invoiceItem = new InvoiceItem({'invoice_id':invoiceID,'description':2,'item_id':3})
    invoiceItem.save()
