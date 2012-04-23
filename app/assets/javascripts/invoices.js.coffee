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
      @model.bind('change:item_id', @render)
    render:   ->
      $(@el).append(Mustache.render('<tr><td>{{ item_id }}</td></tr>',@model.toJSON()))

  #Bind Callbacks To Buttons
  $('#add_part_button').click ->
    invoiceItem = new InvoiceItem({'invoice_id':invoiceID,'description':2,'item_id':3})
    invoiceItem.save()
    invoiceItemView = new InvoiceItemView({ model : invoiceItem })
    invoiceItemView.render()
  #Create Objects
  invoiceItems = new InvoiceItems
  invoiceItems.reset(serverInvoiceItems)
