class Components::Menu < Components::Base
  MenuItem = Data.define(:icon, :label, :link)

  def view_template
    div(class: "mx-auto hidden md:block") do
      if Current.user.present?
        ul(class: "menu menu-lg menu-horizontal bg-base-200 border-base-300 rounded-box my-2 border-1") do
          menu_items.each do |item|
            li do
              a(href: item.link) do
                raw safe(PhosphorIcons::Icon.new(item.icon, width: 24, style: :duotone).to_svg)
                plain item.label
              end
            end
          end
        end
      end
    end

    div(class: "dock md:hidden", data: { controller: "theme" }) do
      menu_items.each do |item|
        button do
          raw safe(PhosphorIcons::Icon.new(item.icon, width: 24, style: :duotone).to_svg)
          span(class: "dock-label") { item.label }
        end
      end
    end
  end

  private

  def menu_items
    [
      MenuItem.new("quotes", "Ёжики", root_path),
      MenuItem.new("hands-praying", "Молитвы", root_path),
      MenuItem.new("notepad", "Заметки", root_path),
      MenuItem.new("users-three", "Группы", root_path),
      MenuItem.new("user", "Профиль", user_path(Current.user))
    ]
    # [
    #   {
    #     icon: "quotes",
    #     label: "Ёжики",
    #     link: root_path
    #   },
    #   {
    #     icon: "hands-praying",
    #     label: "Молитвы",
    #     link: root_path
    #   },
    #   {
    #     icon: "notepad",
    #     label: "Заметки",
    #     link: root_path
    #   },
    #   {
    #     icon: "users-three",
    #     label: "Группы",
    #     link: root_path
    #   },
    #   {
    #     icon: "user",
    #     label: "Профиль",
    #     link: user_path(Current.user)
    #   },
    # ]
  end
end
