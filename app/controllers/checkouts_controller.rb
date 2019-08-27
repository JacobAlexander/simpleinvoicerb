# frozen_string_literal: true

class CheckoutsController < ApplicationController
  expose :invoice, -> { current_invoice }
  expose :product, -> { ProductQuery.new.relation.find_by(id: params[:id]) }

  def show; end

  def close_invoice
    if CloseInvoice.call(invoice, session: session).result
      flash[:success] = "Checkout successfully closed!"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to root_path
  end

  def add_product
    AddProductToInvoice.call(product, invoice_id: invoice.id).result
  end

  def add_product_by_code
    product = ProductQuery.new.find_by_code(params.dig(:product, :code))
    AddProductToInvoice.call(product, invoice_id: invoice.id).result
  end

  def remove_product
    RemoveProductFromInvoice.call(product, invoice_id: invoice.id).result
  end
end
