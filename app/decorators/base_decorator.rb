# frozen_string_literal: true

class BaseDecorator < SimpleDelegator
  attr_reader :model

  def initialize(model)
    @model = model
    super(model)
  end
end
