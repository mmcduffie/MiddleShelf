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
      @collection = new InvoiceItems()
      @collection.reset(serverInvoiceItems)
     
      #alert @collection.at(0).get('description')
      @model = new InvoiceItem({'invoice_id':invoiceID,'description':2,'item_id':3}) #kill me!

      @collection.bind('change:item_id', @render)
    events:
      'click a#add_part_button': 'addItem'
    render:     ->
      _(@collection.models).each (item) =>
        @appendItem(item)
      $(@el).append(Mustache.render('<tr><td>{{ item_id }}</td></tr>',@model.toJSON()))
    addItem:    ->
      invoiceItem = new InvoiceItem({'invoice_id':invoiceID,'description':2,'item_id':3})
      invoiceItem.save()
      invoiceItemView = new InvoiceItemView({ model : invoiceItem })
      invoiceItemView.render()

  #Bind Callbacks To Buttons
  #$('#add_part_button').click ->
  #  invoiceItem = new InvoiceItem({'invoice_id':invoiceID,'description':2,'item_id':3})
  #  invoiceItem.save()
  #  invoiceItemView = new InvoiceItemView({ model : invoiceItem })
  #  invoiceItemView.render()
  #Create Objects
  
  #invoiceItems = new InvoiceItems
  #invoiceItems.reset(serverInvoiceItems)

  invoiceItemView = new InvoiceItemView()
