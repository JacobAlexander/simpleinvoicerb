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

class Product < ApplicationRecord
  acts_as_paranoid
  has_many :invoice_products
  has_many :invoices, through: :invoice_products

  after_initialize :init
  before_validation :format_before_validation

  validates :name,  presence: true,
                    uniqueness: true
  validates :code,  presence: true,
                    uniqueness: true,
                    format: {
                      with: /\A^[a-z0-9]+$\z/,
                      message: 'must be alphanumeric'
                    }
  validates :price, presence: true,
                    numericality: { greater_than: 0.0 }

  private

  def init
    return unless new_record?

    self.price ||= 9999.0
  end

  def format_before_validation
    self.code = code.try(:downcase) # Ensure downcase code
  end
end
