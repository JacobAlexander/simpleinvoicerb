# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  code       :string           not null
#  price      :decimal(8, 2)    not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#

# This will guess the User class
FactoryBot.define do
  factory :product do
    name   { "%s #%s" % [Faker::Book.title, Faker::Number.number(digits: 5)] }
    code   { Faker::Code.asin }
    price  { Faker::Number.decimal(l_digits: 3) }
  end
end
