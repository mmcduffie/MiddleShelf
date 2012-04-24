$ ->
  class InvoiceItem extends Backbone.Model
    url:      '/invoice_items'

  class InvoiceItems extends Backbone.Collection
    model:    InvoiceItem
    url:      '/invoice_items'

  class InvoiceItemView extends Backbone.View
    el:       $('#invoice_items')
    tagName:  'td'
    initialize: ->
      @collection = new InvoiceItems()
      @collection.reset(serverInvoiceItems)
      @collection.bind('change:item_id', @render)
      @render()
    events:
      'click button#add': 'addItem'
    render:     =>
      $(@el).empty()
      _(@collection.models).each (item) =>
        @appendItem(item)
      $(@el).append("<button id='add'>Add Item</button>")
    addItem:    ->
      invoiceItem = new InvoiceItem({'invoice_id':invoiceID,'description':2,'item_id':3})
      invoiceItem.save()
      @collection.add(invoiceItem)
      @render()
    appendItem: (item) ->
      $(@el).append(Mustache.render('<tr><td>{{ item_id }}</td></tr>',item.toJSON()))

  invoiceItemView = new InvoiceItemView()
