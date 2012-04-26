$ ->
  class InvoiceItem extends Backbone.Model
    url: =>
      if @id isnt undefined
        "/invoice_items/#{@id}"
      else
        '/invoice_items'

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
      'click button#delete_item': 'deleteItem'
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
      $(@el).append("<tr><td></td><td><button id='add_item'>Add Item</button></td><td><button id='delete_item'>Delete Item</button></td></tr>")
      $('#add_item').button({ icons: {primary:'ui-icon-plusthick'} })
      $('#delete_item').button({ icons: {primary:'ui-icon-minusthick'} })
    addItem:    ->
      $(@el).append(Mustache.render(@addItemTemplate))
      $('#add_item_dialog').dialog({ modal: true })
      $('#add_item_ok').button()
      $('#add_item_ok').click =>
        @addItemOk()
    addItemOk:  ->
      item_id = $('#item_id').val()
      item_description = $('#item_description').val()
      invoiceItem = new InvoiceItem({'invoice_id':invoiceID,'description':item_description,'item_id':item_id})
      invoiceItem.save()
      @collection.add(invoiceItem)
      $('#add_item_dialog').dialog('destroy')
      $('#add_item_dialog').remove()
    appendItem: (item) =>
      $(@el).append(Mustache.render('<tr><td><input type="checkbox" id="{{ id }}" /></td><td>{{ item_id }}</td><td>{{ description }}</td></tr>',item.toJSON()))
    deleteItem: ->
      _($('#invoice_items input[type=checkbox]')).each (checkbox)=>
        if checkbox.checked
          id = $(checkbox).attr('id')
          @collection.get(id).destroy()
          @render()

  invoiceItemView = new InvoiceItemView()
