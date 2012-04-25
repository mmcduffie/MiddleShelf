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
      @collection.bind('add', @appendItem)
      @render()
    events:
      'click button#add_item': 'addItem'
      'click button#add_item_ok': 'addItemOk'
    addItemTemplate:
      """
      <div id="add_item_dialog">
        <table>
          <tr>
            <td>
              <input type='text' id='item_id'></input>
            </td>
          </tr>
          <tr>
            <td>
              <input type='text' id='item_description'></input>
            </td>
          </tr>
          <tr>
            <td>
              <button id='add_item_ok'>OK</button>
            </td>
          </tr>
        </table>
      </div>
      """
    render:     =>
      $(@el).empty()
      _(@collection.models).each (item) =>
        @appendItem(item)
      $(@el).append("<button id='add_item'>Add Item</button>")
      $('#add_item').button()
    addItem:    ->
      $(@el).append(Mustache.render(@addItemTemplate))
      $('#add_item_dialog').dialog({ modal: true })
      $('#add_item_ok').button()
      $('#add_item_ok').click =>
        @addItemOk()    # Hackish, wrong, and hackishly wrong.
    addItemOk:  ->
      item_id = $('#item_id').val()
      item_description = $('#item_description').val()
      invoiceItem = new InvoiceItem({'invoice_id':invoiceID,'description':item_description,'item_id':item_id})
      invoiceItem.save()
      @collection.add(invoiceItem)
      $('#add_item_dialog').dialog('destroy')
      $('#add_item_dialog').remove()
    appendItem: (item) =>
      $(@el).append(Mustache.render('<tr><td>{{ item_id }}</td><td>{{ description }}</td></tr>',item.toJSON()))

  invoiceItemView = new InvoiceItemView()
