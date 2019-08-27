# frozen_string_literal: true

class RemoveHiddenFieldFromProducts < ActiveRecord::Migration[6.0]
  def up
    remove_column :products, :hidden
  end

  def down
    add_column :products, :hidden, :boolean, default: false, null: false
  end
end
