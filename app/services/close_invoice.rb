# frozen_string_literal: true

class CloseInvoice < BaseService
  attr_reader :invoice, :session
  def initialize(invoice, session: nil)
    @invoice = invoice
    @session = session
  end

  def call
    invoice.update!(closed: true, number: generate_number)
    clear_stored_invoice_id
    true
  rescue StandardError
    false
  end

  def self.generate_number(time, invoice_num)
    # Generate number like 2019/09/3
    [time.strftime("%Y/%m/"), invoice_num].join
  end

  private

  def clear_stored_invoice_id
    session[:invoice_id] = nil if session
  end

  def generate_number
    self.class.generate_number(Time.current, invoice_number)
  end

  def invoice_number
    InvoiceQuery.new.relation.closed.size + 1
  end
end
