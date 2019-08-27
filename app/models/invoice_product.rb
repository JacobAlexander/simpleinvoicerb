# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_products
#
#  id         :bigint           not null, primary key
#  invoice_id :bigint           not null
#  product_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class InvoiceProduct < ApplicationRecord
  class ClosedInvoiceError < StandardError
    def message; 'Cannot add product to closed invoice'; end
  end
  belongs_to :invoice
  belongs_to :product
  before_save :prevent_adding_to_or_changing_product_in_closed_invoice

  private

  def prevent_adding_to_or_changing_product_in_closed_invoice
    raise ClosedInvoiceError if invoice.closed?
  end
end
