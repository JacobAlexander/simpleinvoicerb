# frozen_string_literal: true

class InvoicesController < ApplicationController
  expose :invoices, -> {
    InvoiceQuery.new.all_with_total_price.map { |i| InvoiceDecorator.new(i) }
  }
  expose :invoice, decorate: ->(i){ InvoiceDecorator.new(i) }

  def index; end

  def show; end
end
