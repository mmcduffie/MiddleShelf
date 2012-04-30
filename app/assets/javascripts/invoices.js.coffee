$ ->
  class InvoiceItem extends Backbone.Model
    url: =>
      if @id is undefined
        '/invoice_items'
      else
        "/invoice_items/#{@id}"

  class InvoiceItems extends Backbone.Collection
    model:    InvoiceItem
    url:      '/invoice_items'

  class InvoiceItemView extends Backbone.View
    el:       $('#invoice_items')

    tagName:  'td'
    initialize: ->
      @collection = new InvoiceItems()
      @collection.on('reset remove', @render)
      @collection.on('add', @appendItem)
      @collection.reset(serverInvoiceItems)
      $(@el).append("<tr><td></td><td><button id='add_item'>Add Item</button></td><td><button id='delete_item'>Delete Item</button></td></tr>")
      $('#add_item').button({ icons: {primary:'ui-icon-plusthick'} })
      $('#delete_item').button({ icons: {primary:'ui-icon-minusthick'} })

    events:
      'click button#add_item': 'addItem'
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
        </table>
      </div>
      """

    titleRowTemplate:
      """
      <tr>
        <th>
        
        </th>
        <th>
          Item #
        </th>
        <th>
          Description
        </th>
      </tr>
      """

    render:     =>
      $("#invoice_items_table").empty()
      $("#invoice_items_table").append(Mustache.render(@titleRowTemplate))
      _(@collection.models).each (item) =>
        @appendItem(item)

    addItem:    ->
      $(@el).append(Mustache.render(@addItemTemplate))
      $('#add_item_dialog').dialog
        modal: true
        draggable: false
        title: "Add Item"
        buttons: [
          {
            text:  "OK"
            click: =>
              @addItemOk()
          }
        ]

    addItemOk:  ->
      item_id = $('#item_id').val()
      item_description = $('#item_description').val()
      invoiceItem = new InvoiceItem({'invoice_id':invoiceID,'description':item_description,'item_id':item_id})
      invoiceItem.save 'item_id', item_id, 
        success: =>
          @collection.add(invoiceItem)
          $('#add_item_dialog').dialog('destroy')
          $('#add_item_dialog').remove()

    appendItem: (item) =>
      $("#invoice_items_table").append(Mustache.render('<tr><td><input type="checkbox" id="{{ id }}" /></td><td>{{ item_id }}</td><td>{{ description }}</td></tr>',item.toJSON()))

    deleteItem: ->
      _($('#invoice_items input[type=checkbox]')).each (checkbox)=>
        if checkbox.checked
          id = $(checkbox).attr('id')
          @collection.get(id).destroy()

  invoiceItemView = new InvoiceItemView()
