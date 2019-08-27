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

require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is valid with valid attributes' do
    product = build(:product)
    expect(product).to be_valid
  end

  it 'is not valid without a name' do
    product = build(:product, name: nil)
    expect(product).to_not be_valid
  end

  it 'is not valid without a code' do
    product = build(:product, code: nil)
    expect(product).to_not be_valid
  end

  it 'is not valid without a price' do
    product = build(:product, price: nil)
    expect(product).to_not be_valid
  end

  it 'is valid with lphanumeric code' do
    product = build(:product, code: '123ABC')
    expect(product).to be_valid
  end

  it 'is not valid with nonalphanumeric code' do
    product = build(:product, code: '123 _ABC')
    expect(product).to_not be_valid
  end

  it 'is not valid if price is equal or lower than 0.0' do
    [0, 0.0, '0', -0.1, -2].each do |p|
      product = build(:product, price: p)
      expect(product).to_not be_valid
    end
  end

  it 'is not valid if name is not unique' do
    product1 = create(:product, name: 'Ship', code: 'ABC')
    product2 = build(:product,  name: 'Ship', code: 'EFG')
    expect(product2).to_not be_valid
    expect { product2.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is not valid if code is not unique' do
    product1 = create(:product, name: 'Ship1', code: 'DOG')
    product2 = build(:product,  name: 'Ship2', code: 'DOG')
    expect(product2).to_not be_valid
    expect { product2.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
