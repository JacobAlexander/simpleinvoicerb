# frozen_string_literal: true

class InvoicePresenter < BasePresenter
  def total_price
    helpers.number_to_currency(model.total_price_summary)
  end

  def total_price_text
    "Current Invoice: %s" % total_price
  end

  def number
    model.number || ''
  end
end
