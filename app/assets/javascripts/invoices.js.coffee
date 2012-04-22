$ ->
  #Classes
  class InvoiceItem extends Backbone.Model
    url:      '/invoice_items'

  class InvoiceItems extends Backbone.Collection
    model:    InvoiceItem
    url:      '/invoice_items'

  class InvoiceItemView extends Backbone.View
    el:       $('#invoice_items')
    tagName:  'td'
    initialize: ->
      _.bindAll this, 'render'
    render:   ->
      $(@el).html(Mustache.render('<tr><td>{{ item_id }}</td></tr>',@model.toJSON()))
      # This may be backwards when I start calling render from the change even on the models...

  #Bind Callbacks To Buttons
  $('#add_part_button').click ->
    invoiceItem = new InvoiceItem({'invoice_id':invoiceID,'description':2,'item_id':3})
    invoiceItem.save()
  #Create Objects
  invoiceItems = new InvoiceItems
  invoiceItems.reset(serverInvoiceItems)

  invoiceItemView = new InvoiceItemView

  testModel = invoiceItems.at(0)           # Use 'at' to get an element from a collection.
  #alert testModel.get('description')      # Use 'get' to get an attribute from a model.

  invoiceItemView.model = testModel        # really, we should be binding the render method in the view to the change event in the model.

  invoiceItemView.render()                 # Render replaces everything in the table with new data. -EDIT not true anymore.
