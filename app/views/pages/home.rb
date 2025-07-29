class Views::Pages::Home < Views::Base
  def initialize(meditation:)
    @meditation = meditation
  end

  def page_title = "Articles"
  def layout = Layout

  def view_template
    h1(class: "text-red-500") { "Hello !!!" }
    @meditation.entry.each do |par|
      p { par["text"].html_safe }
    end
  end
end
