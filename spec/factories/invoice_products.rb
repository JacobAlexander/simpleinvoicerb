# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_products
#
#  id         :bigint           not null, primary key
#  invoice_id :bigint           not null
#  product_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :invoice_product do
    invoice { nil }
    product { nil }
  end
end
