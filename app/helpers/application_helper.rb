module ApplicationHelper
  def page_title
    title = [t('shared.name')]
    title.prepend @page_title if @page_title.present?
    return title.join(' &ndash; ').html_safe
  end
end
