# frozen_string_literal: true

class ProductPresenter < BasePresenter
  def code
    model.code.upcase
  end

  def price
    helpers.number_to_currency(model.price)
  end
end
