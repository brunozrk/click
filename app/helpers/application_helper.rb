module ApplicationHelper
  def message(messages)
    return '' if messages.empty?

    messages = messages.map { |msg| content_tag(:p, msg) }.join

    html = <<-HTML
    <div class="callout callout-danger">
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end
