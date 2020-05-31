module ApplicationHelper
  def page_title
    title = [t('shared.name')]
    title.prepend @page_title if @page_title.present?
    return title.join(' &ndash; ').html_safe
  end

  def default_body_classes
    controller_path_array = controller_path.split('/')
    controller_path_array.append action_name
    controller_path_array.append Rails.env if Rails.env.test?
    controller_path_array.join(' ')
  end

  def svg_icon(path, name, options = {})
    width = options[:width].present? ? options[:width] : '16'
    height = options[:height].present? ? options[:height] : '16'
    css_class = options[:class].present? ? options[:class] : 'black'

    tag = "<svg width=\"#{width}px\" height=\"#{height}px\" viewBox=\"0 0 #{width} #{height}\" class=\"icon #{css_class}\">" +
          "<use xlink:href=\"#{ asset_path path }##{name}\"></use>" +
          "</svg>"

    tag.html_safe
  end

  def info_panel_tag(message, options = {})
    options[:container_only] = options[:container_only] || false

    if options[:class].present?
      options[:class] = ['info_panel', options[:class]].flatten.join(' ')
    else
      options[:class] = 'info_panel'
    end

    render partial: 'shared/info_panel', locals: { message: message, options: options }
  end

  def form_actions(inline: false, plain: false, centered: false, &block)
    css_class = %w(form_actions)
    css_class << 'inline' if inline
    css_class << 'plain' if plain
    css_class << 'centered' if centered
    css_class = css_class.join(' ')
    actions = tag.div capture(&block), class: 'inner'
    actions = tag.div actions, class: css_class
  end
end
