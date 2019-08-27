# frozen_string_literal: true

# == Schema Information
#
# Table name: invoices
#
#  id         :bigint           not null, primary key
#  number     :string
#  closed     :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it 'is valid with valid attributes' do
    invoice = build(:invoice)
    expect(invoice).to be_valid
  end

  context "when products adding" do
    context "ensure to be opened invoice" do
      it 'will create new if there is no any' do
        product = create(:product)
        expect{ AddProductToInvoice.call(product) }.to change{ Invoice.all.size }.from(0).to(1)
      end
      it 'will create new if there is no any opened' do
        invoice = create(:invoice, :with_products)
        product = create(:product)
        closed = CloseInvoice.call(invoice)
        expect{ AddProductToInvoice.call(product, invoice_id: invoice.id) }.to change{ Invoice.all.size }.by(1)
        added = AddProductToInvoice.call(product, invoice_id: invoice.id)
        expect(added.result).to be true
      end
      it 'will assign products to opened invoice' do
        invoice = create(:invoice, :with_products)
        product = create(:product)
        expect{ AddProductToInvoice.call(product, invoice_id: invoice.id) }.to change{ Invoice.find(invoice.id).products.size }.by(1)
        expect(Invoice.find(invoice.id).products.pluck(:id)).to include product.id
      end
    end
  end

  context 'when products qty change' do
    it 'is increase product qty if product added' do
      invoice = create(:invoice, :with_products)
      product = create(:product)
      expect{ AddProductToInvoice.call(product, invoice_id: invoice.id) }.to change{ Invoice.find(invoice.id).products.size }.by(1)
    end
    it 'is decrease product qty if product removed' do
      invoice = create(:invoice, :with_products)
      products_qty = invoice.products.size
      product = invoice.products.last
      expect{ RemoveProductFromInvoice.call(product, invoice_id: invoice.id) }.to change{ Invoice.find(invoice.id).products.size }.from(products_qty).to(products_qty - 1)
    end
  end

  context "when is opened" do
    it 'should have empty number field' do
      invoice = create(:invoice, :with_products)
      expect(invoice.number).to be_nil
      expect(invoice.closed).to be false
    end
    it 'is not possible to close if no products assigned' do
      invoice = create(:invoice)
      closed = CloseInvoice.call(invoice)
      expect(closed.result).to be false
      expect(closed.invoice).to_not be_valid
    end
    it 'is possible to close if there is one ore more products' do
      invoice = create(:invoice, :with_products)
      closed = CloseInvoice.call(invoice)
      expect(closed.result).to be true
      expect(closed.invoice.closed).to be true
    end
  end

  context "when is closed" do
    it 'should have number set to: YY/MM/num_of_month' do
      invoice = create(:invoice, :with_products)
      number = CloseInvoice.generate_number(Time.now, InvoiceQuery.new.relation.closed.size + 1)
      closed = CloseInvoice.call(invoice)
      expect(closed.invoice.number).to eq(number)
    end
    it 'is not possible to add product to' do
      invoice = create(:invoice, :with_products)
      invoice_products_qty = invoice.products.size
      product = create(:product)
      closed = CloseInvoice.call(invoice)
      add = AddProductToInvoice.call(product, invoice_id: invoice.id)
      expect(Invoice.find(invoice.id).products.size).to be invoice_products_qty
      # This one never return false because service
      # creates new invoice if provided one is closed or doesn't exist
      # expect(add.result).to be false
      expect{ invoice.products << product }.to raise_error(InvoiceProduct::ClosedInvoiceError)
    end
    it 'is not possible to remove product from' do
      invoice = create(:invoice, :with_products)
      invoice_products_qty = invoice.products.size
      product = invoice.products.last
      closed = CloseInvoice.call(invoice)
      removed = RemoveProductFromInvoice.call(product, invoice_id: invoice.id)
      expect(Invoice.find(invoice.id).products.size).to be invoice_products_qty
    end
    it 'is not possible to open invoice' do
      invoice = create(:invoice, :with_products)
      closed = CloseInvoice.call(invoice)
      closed.invoice.closed = false
      closed.invoice.update(closed: false)
      expect(closed.invoice.update(closed: false)).to be false
    end
    it 'is possible to destroy products and keep invoices not affected by that action' do
      invoice = create(:invoice, :with_products)
      assigned_rpoducts_qty = invoice.products.size
      products = Product.all
      products_qty = products.size
      Product.last.destroy
      expect(invoice.products.size).to be assigned_rpoducts_qty
      expect(Product.all.size).to be products_qty - 1
    end
  end
end
