# frozen_string_literal: true

class BasePresenter < SimpleDelegator
  attr_reader :view_context, :model

  def initialize(model, view_context)
    @view_context = view_context
    @model = model
    super(model)
  end

  alias_method :h, :view_context
  alias_method :helpers, :view_context
end
