require 'pry'
class ReportPresenter < Burgundy::Item

  def estimated_first_exit
    return first_exit if first_exit.present?
    if estimable?(0)
      h.content_tag(:span, title: 'Saída Estimada', class: 'text-muted') do
        h.content_tag(:i, nil, class: 'fa fa-fw fa-sign-out') +
          estimated_exit('first').strftime('%H:%M')
      end
    end
  end

  def estimated_second_exit
    return second_exit if second_exit.present?
    if estimable?(1)
      h.content_tag(:span, title: 'Saída Estimada', class: 'text-muted') do
        h.content_tag(:i, nil, class: 'fa fa-fw fa-sign-out') +
          estimated_exit('second').strftime('%H:%M')
      end
    end
  end

  def estimated_third_exit
    return third_exit if third_exit.present?
    if estimable?(2)
      h.content_tag(:span, title: 'Saída Estimada', class: 'text-muted') do
        h.content_tag(:i, nil, class: 'fa fa-fw fa-sign-out') +
          estimated_exit('third').strftime('%H:%M')
      end
    end
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

  def estimable?(entry)
    entries.at(entry).present? &&
    entries.drop(entry + 1).reject{|e| e.blank?}.blank? &&
    exits.drop(entry + 1).reject{|e| e.blank?}.blank?
  end

  def nonworking_day
    return if working_day
    '(Dia não útil)'
  end

  def estimated_exit entry
    current_entry = "#{entry}_entry".to_sym
    Time.parse(send(current_entry)) + balance.fetch(:time)
  end
end
