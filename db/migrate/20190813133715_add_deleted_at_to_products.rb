# frozen_string_literal: true

class AddDeletedAtToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :deleted_at, :datetime, precision: 6
    add_index :products, :deleted_at
  end
end
