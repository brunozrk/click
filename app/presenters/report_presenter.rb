class ReportPresenter < Burgundy::Item
  def last_exit
    return second_exit unless second_exit.blank?
    h.content_tag(:span, title: 'Saída Estimada', class: 'text-muted') do
      h.content_tag(:i, nil, class: 'fa fa-fw fa-sign-out') +
        estimated_exit.strftime('%H:%M')
    end if estimated_exit
  end
end
