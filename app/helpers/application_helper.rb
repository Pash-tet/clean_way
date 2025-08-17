module ApplicationHelper
  def icon(icon_name, style: :duotone, **options)
    phosphor_icon(icon_name, style:, **options)
  end

  def paragraph_class(type: nil)
    return "mt-4" unless type

    case type
    when "quote"
      "italic"
    when "quote_source"
      "text-right italic"
    else
      "mt-4"
    end
  end

  def menu
    [
      {
        icon: "quotes",
        label: "Ёжики",
        link: root_path
      },
      {
        icon: "hands-praying",
        label: "Молитвы",
        link: prayers_path
      },
      {
        icon: "notepad",
        label: "Заметки",
        link: root_path
      },
      {
        icon: "users-three",
        label: "Группы",
        link: root_path
      },
      {
        icon: "user",
        label: "Профиль",
        link: user_path(Current.user)
      },
    ]
  end
end
