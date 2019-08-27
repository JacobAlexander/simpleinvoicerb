# frozen_string_literal: true

module ApplicationHelper
  def action_class
    ['box', params[:controller], params[:action]].join('-')
  end

  def present(model_obj, presenter: nil)
    # Usage:
    # present(@product) do |p|
    #   %h1= p.title
    #   %h2= p.price
    # end
    presenter_klass = "#{presenter || model_obj.class}Presenter"
                      .gsub('Decorator', '')
                      .constantize
    presenter_obj = presenter_klass.new(model_obj, self)
    block_given? ? yield(presenter_obj) : presenter_obj
  end

  # rubocop:disable Naming/UncommunicativeMethodParamName
  def back_url(or: nil)
    # Use truly previous url from session or use passed
    same_place = session[:back_url] == request.original_url
    same_place ? binding.local_variable_get(:or) : session[:back_url]
  end
  # rubocop:enable Naming/UncommunicativeMethodParamName

  def render_flash
    levels = {
      notice: 'alert-info',
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-danger'
    }
    alert_html = <<-HTML
      <div class='alert %s alert-dismissible show fade'>
        %s
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    HTML

    flash.map { |k, v| alert_html % [levels[k.to_sym], v] }
         .join
         .then { |alerts| "<div class='alerts'>#{alerts}</div>".html_safe }
  end
end
