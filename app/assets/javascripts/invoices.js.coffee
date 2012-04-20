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
  #Create Objects
  invoiceItems = new InvoiceItems
  invoiceItems.reset(serverInvoiceItems)
  testModel = invoiceItems.at(0)          # Use 'at' to get an element from a collection.
  alert testModel.get('description')      # Use 'get' to get an attribute from a model.
