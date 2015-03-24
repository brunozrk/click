class ReportPresenter < Burgundy::Item
  def last_exit
    return second_exit unless second_exit.blank?
    h.content_tag(:span, title: 'Saída Estimada', class: 'text-muted') do
      h.content_tag(:i, nil, class: 'fa fa-fw fa-sign-out') +
        estimated_exit.strftime('%H:%M')
    end if estimated_exit
  end

  def info
    return if notice.blank? && working_day
    h.content_tag(
      :i, nil,
      class: 'fa fa-fw fa-info-circle',
      popover: '',
      data: {
        toggle: 'popover',
        content: "#{notice} #{nonworking_day}",
        placement: 'left'
      }
    )
  end

  private

  def nonworking_day
    return if working_day
    '(Dia não útil)'
  end

  def estimated_exit
    return unless can_estimate?
    Time.parse(second_entry) + balance.fetch(:time)
  end

  def can_estimate?
    return false unless second_exit.blank?
    [first_entry, first_exit, second_entry].each do |f|
      return false if f.blank?
    end
    true
  end
end
