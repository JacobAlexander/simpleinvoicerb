# frozen_string_literal: true

class BaseService
  attr_reader :result

  def self.call(*args)
    new(*args).tap { |s| s.instance_variable_set("@result", s.call) }
  end

  def call; raise NotImplementedError; end
end
