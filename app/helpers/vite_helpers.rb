module ViteHelpers
  def vite_client
    script(src: vite_manifest.vite_client_src, type: "module")
  end

  def vite_javascript(name, options:)
    script(src: vite_asset_path(name, type: :javascript), type: "module", **options)
  end

  def vite_asset_path(name, **)
    vite_manifest.path_for(name, **)
  end

  def vite_stylesheet(name, **)
    href = vite_asset_path(name, type: :stylesheet)

    link(rel: "stylesheet", href:, **)
  end

  def vite_manifest
    ViteRuby.instance.manifest
  end
end
