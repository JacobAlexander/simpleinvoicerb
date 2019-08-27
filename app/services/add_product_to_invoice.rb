# frozen_string_literal: true

class AddProductToInvoice < BaseService
  attr_reader :product, :invoice
  def initialize(product, invoice_id: nil)
    @product = product
    @invoice = EnsureCurrentInvoice.call(id: invoice_id).result
  end

  def call
    !!InvoiceProduct.create!(invoice_id: invoice.id, product_id: product.id)
  rescue InvoiceProduct::ClosedInvoiceError
    call(product, invoice_id: EnsureCurrentInvoice.call.result)
  rescue StandardError
    false
  end
end
