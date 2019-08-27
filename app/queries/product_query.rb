# frozen_string_literal: true

class ProductQuery < BaseQuery
  # Keep in mind that products can be soft deleted!
  def initialize(relation: Product)
    super
  end

  def find_by_code(code)
    relation.find_by(code: code.downcase)
  end

  def invoice_summary(invoice_id:)
    sql = <<~SQL
      SELECT p.id, p.name, count(p.id) qty, sum(p.price) price
      FROM products p
      JOIN invoice_products ip
      ON p.id = ip.product_id
      WHERE ip.invoice_id = %s
      GROUP BY p.id
    SQL
    relation.find_by_sql(sql % invoice_id)
  end
end
