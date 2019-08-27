# frozen_string_literal: true

class CreateJoinTableInvoiceProduct < ActiveRecord::Migration[6.0]
  def change
    create_join_table :invoices, :products do |t|
      t.index :invoice_id
      t.index :product_id
      t.index [:invoice_id, :product_id]
      t.index [:product_id, :invoice_id]
    end
  end
end
