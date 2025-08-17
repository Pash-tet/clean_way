class Views::Users::Show < Views::Base
  def view_template
    div(class: "text-2xl") { "Имя: " + Current.user.name }
    div(class: "text-2xl") { "Email: " + Current.user.email }
    div(class: "text-2xl") { "Password: " + Current.user.password_digest }
    a(href: session_path, data: { turbo_method: :delete }) { "Выйти" }
  end
end
