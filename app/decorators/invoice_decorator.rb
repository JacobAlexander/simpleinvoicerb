# frozen_string_literal: true

class InvoiceDecorator < BaseDecorator
  def products_summary
    @products_summary ||= ProductQuery.new.invoice_summary(invoice_id: model.id)
  end

  def total_price_summary
    @total_price_summary ||= products_summary.sum(&:price)
  end
end
