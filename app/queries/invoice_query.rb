# frozen_string_literal: true

class InvoiceQuery < BaseQuery
  def initialize(relation: Invoice)
    super
  end

  module Scopes
    def opened
      where(closed: false)
    end

    def closed
      where(closed: true)
    end
  end

  def find_opened_or_create(id: nil)
    relation.opened.find_by(id: id) || relation.opened.first_or_create!
  end

  def all_with_total_price
    sql = <<~SQL
      WITH baskets_products AS (
            SELECT p.id, ip.invoice_id, p.name, p.price
            FROM invoice_products ip
            JOIN products p
            ON ip.product_id = p.id
      )
      SELECT i.*, sum(bp.price) total_price
      FROM invoices i
      FULL OUTER JOIN baskets_products bp ON bp.invoice_id = i.id
      GROUP BY i.id
      ORDER BY i.created_at DESC
    SQL
    relation.find_by_sql(sql)
  end
end
