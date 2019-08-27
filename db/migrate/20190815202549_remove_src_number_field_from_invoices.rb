# frozen_string_literal: true

class RemoveSrcNumberFieldFromInvoices < ActiveRecord::Migration[6.0]
  def up
    remove_column :invoices, :src_number
  end

  def down
    add_column :invoices, :src_number, :integer
  end
end
