# frozen_string_literal: true

# == Schema Information
#
# Table name: invoices
#
#  id         :bigint           not null, primary key
#  number     :string
#  closed     :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Invoice < ApplicationRecord
  has_many :invoice_products
  has_many :products, through: :invoice_products
  validates :number, presence: true,
                     format: { with: %r{\d{4}/[0,1,2,3]\d/\d{1,10}}i },
                     if: :closed
  validates :closed, inclusion: { in: [true, false] }
  validate :closing_with_products_validation
  validate :opening_when_closed_validation

  private

  def closing_with_products_validation
    if closed && products.empty? # rubocop:disable Style/GuardClause
      errors.add(:closed, "not possible without products assigned")
    end
  end

  def opening_when_closed_validation
    if closed_change === [true, false] # rubocop:disable Style/GuardClause, Style/CaseEquality
      errors.add(:closed, "not possible to open already closed")
    end
  end
end
