require 'pry'
class ReportPresenter < Burgundy::Item

  def estimated_time(index)
    return index_exit(index) if index_exit(index).present?
    if estimable?(index_to_integer(index))
      h.content_tag(:span, title: 'Saída Estimada', class: 'text-muted') do
        h.content_tag(:i, nil, class: 'fa fa-fw fa-sign-out') +
          estimated_exit(index).strftime('%H:%M')
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
  def index_exit(index)
    send("#{index}_exit".to_sym)
  end

  def index_to_integer(index)
    case index
    when :first
      0
    when :second
      1
    when :third
      2
    end
  end

  def estimable?(entry)
    entries.at(entry).present? &&
    entries.drop(entry + 1).reject{|e| e.blank?}.blank? &&
    exits.drop(entry + 1).reject{|e| e.blank?}.blank?
  end

  def nonworking_day
    return if working_day
    '(Dia não útil)'
  end

  def estimated_exit(entry)
    Time.parse(send("#{entry}_entry".to_sym)) + balance.fetch(:time)
  end
end
