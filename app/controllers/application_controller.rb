# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :store_back_url
  helper_method :current_invoice, :stored_invoice_id

  private

  def store_back_url
    session[:back_url] = request.referer
  end

  def stored_invoice_id
    session[:invoice_id] = session[:invoice_id] || EnsureCurrentInvoice.call.result.id
  end

  def current_invoice
    @current_invoice ||= EnsureCurrentInvoice.call(id: stored_invoice_id).result
                                             .then { |i| InvoiceDecorator.new(i) }
  end
end
