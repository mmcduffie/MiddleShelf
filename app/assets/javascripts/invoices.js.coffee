class Invoice extends Backbone.Model
  urlRoot:    '/invoice'
  defaults:
    customerId: '2'

invoice = new Invoice
invoice.set customerId: '1'
test = invoice.get 'customerId'
alert test
