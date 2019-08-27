# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
  {
    name: 'Eloquent Ruby',
    code: 'A',
    price: 99.99
  },
  {
    name: 'Clean Ruby',
    code: 'B',
    price: 100.0
  },
  {
    name: 'The Well-Grounded Rubyis',
    code: 'C',
    price: 200.0
  },
  {
    name: 'Ruby Science',
    code: 'D',
    price: 49.99
  },
  {
    name: 'Confident Ruby',
    code: 'E',
    price: 50.0
  },
].each { |p| Product.create!(p) }
