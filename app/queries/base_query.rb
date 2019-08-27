# frozen_string_literal: true

class BaseQuery
  attr_reader :relation
  def initialize(relation:)
    @relation = build_relation(relation)
  end

  private

  def scopes_module
    module_name = "%s::Scopes" % self.class
    module_name.constantize if self.class.const_defined?(module_name)
  end

  def build_relation(relation)
    scopes_module ? relation.extend(scopes_module) : relation
  end
end
