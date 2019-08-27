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

# This will guess the User class
FactoryBot.define do
  factory :invoice do
    closed { false }

    trait :with_products do
      products { create_list :product, 3 }
    end
  end
end
