# frozen_string_literal: true

class RemoveProductFromInvoice < BaseService
  attr_reader :product, :invoice
  def initialize(product, invoice_id: nil)
    @product = product
    @invoice = EnsureCurrentInvoice.call(id: invoice_id).result
  end

  def call
    !!InvoiceProduct.find_by(invoice_id: invoice.id, product_id: product.id)&.destroy!
  rescue StandardError
    false
  end
end
