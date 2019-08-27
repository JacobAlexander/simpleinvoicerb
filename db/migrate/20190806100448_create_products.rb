# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.boolean :hidden, default: false, null: false

      t.timestamps
    end
  end
end
