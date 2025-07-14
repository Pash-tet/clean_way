module ApplicationHelper
  def icon(icon_name, style: :duotone, **options)
    phosphor_icon(icon_name, style:, **options)
  end
end
