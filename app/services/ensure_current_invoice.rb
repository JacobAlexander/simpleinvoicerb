# frozen_string_literal: true

class EnsureCurrentInvoice < BaseService
  attr_reader :invoice_id
  def initialize(id: nil)
    @invoice_id = id
  end

  # Usage:
  # EnsureCurrentInvoice.call.result
  # => < Latest opened Invoice or fresh one >
  # EnsureCurrentInvoice.call(id: 1).result
  # => < Opened invoice with id 1 or fresh one >
  def call
    InvoiceQuery.new.find_opened_or_create(id: invoice_id)
  end
end
