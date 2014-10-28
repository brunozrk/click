module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:p, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html(sentence, messages)
  end

  def devise_alert_messages!
    return '' unless alert

    html('Ops!', "<p>#{alert}</p>")
  end

  private

  def html(sentence, messages)
    html = <<-HTML
    <div class="bg-danger callout callout-danger">
      <h4>#{sentence}</h4>
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end
