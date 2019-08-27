# frozen_string_literal: true

class DropInvoicesproductsTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :invoices_products
  end

  def down
    create_join_table :invoices, :products do |t|
      t.index :invoice_id
      t.index :product_id
      t.index [:invoice_id, :product_id]
      t.index [:product_id, :invoice_id]
    end
  end
end
