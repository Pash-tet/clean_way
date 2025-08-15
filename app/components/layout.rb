class Components::Layout < Components::Base
  include Phlex::Rails::Helpers::CSPMetaTag
  include Phlex::Rails::Helpers::CSRFMetaTags
  include ViteHelpers

  def initialize(page_info)
    @page_info = page_info
  end

  def view_template
    doctype
    html(lang: "ru", data: { theme: "cupcake" }, xmlns: "http://www.w3.org/1999/html") do
      head do
        meta(name: "viewport", content: "width=device-width,initial-scale=1")
        meta(name: "apple-mobile-web-app-capable", content: "yes")
        meta(name: "mobile-web-app-capable", content: "yes")
        csrf_meta_tags
        csp_meta_tag

        # Enable PWA manifest for installable apps (make sure to enable in config/routes.rb too!)
        # link(rel: "manifest", href: pwa_manifest_path(format: :json))

        vite_client if Rails.env.development?
        vite_javascript "application", options: { defer: true, type: "module" }
        vite_stylesheet "application"

        link(rel: "icon", type: "image/png", href: "/icon.png")
        link(rel: "icon", type: "image/svg+xml", href: "/icon.svg")
        link(rel: "apple-touch-icon", href: "/icon.png")

        title { @page_info.title || "Clean Way" }
      end

      body(class: "grid grid-rows-[auto_1fr]") do
        render Components::Menu.new
        main(class: "mx-auto w-full px-4 md:w-2xl lg:w-4xl") { yield }
      end
    end
  end
end
