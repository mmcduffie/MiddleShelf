$ ->
  class Invoice extends Backbone.Model

  class Invoices extends Backbone.Collection
    model:    Invoice
    url:      '/invoices'

  class InvoiceView extends Backbone.View
    initialize: ->
      @model.bind('change', this.render)
      @model.view = this

    render: =>
      $("html").html(Invoice.toJSON())
      this.setContent()
      return this

  invoices = new Invoices
  invoices.reset(invoiceData)

  invoice = new Invoice

  invoiceView = new InvoiceView({ model: invoice })

  invoiceView.render()

  ids = invoices.pluck("customer_id");

  alert ids
