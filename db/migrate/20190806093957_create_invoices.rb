# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string :number
      t.integer :src_number
      t.boolean :closed, default: false, null: false

      t.timestamps
    end
  end
end
