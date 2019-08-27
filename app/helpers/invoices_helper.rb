# frozen_string_literal: true

module InvoicesHelper
  def current_invoice?
    [params[:controller], params[:id]] === ["invoices", stored_invoice_id.to_s] # rubocop:disable  Style/CaseEquality
  end
end
