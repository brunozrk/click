module ApplicationHelper
  def flash_class(type)
    flashes[type]['class']
  end

  def flash_icon(type)
    flashes[type]['icon']
  end

  def message(messages)
    return '' if messages.empty?

    html = <<-HTML
    <div class="callout callout-danger">
      #{messages.map { |msg| content_tag(:p, msg) }.join}
    </div>
    HTML

    html.html_safe
  end

  def popover(content)
    "popover data-toggle='popover' data-content='#{content}'".html_safe
  end

  private

  def flashes
    @flashes ||= {
      'success' => class_and_icon('success', 'fa-check'),
      'error'   => class_and_icon('danger', 'fa-ban'),
      'notice'  => class_and_icon('info', 'fa-info'),
      'alert'   => class_and_icon('warning', 'fa-warning')
    }
  end

  def class_and_icon(cls, icon)
    {
      'class' => cls,
      'icon' => icon
    }
  end
end
