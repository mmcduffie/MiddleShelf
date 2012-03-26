class TodaysInvoicesController < ApplicationController
  # GET /todays_invoices
  # GET /todays_invoices.json
  def index
    @invoices = Invoice.todays

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invoices }
    end
  end
end
