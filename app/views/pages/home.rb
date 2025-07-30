class Views::Pages::Home < Views::Base
  def initialize(meditation:)
    @meditation = meditation
  end

  def view_template
    article(class: "bg-base-200 border-base-400 collapse-arrow border-base-300 collapse border") do
      input(type: "checkbox")
      div(class: "collapse-title text-xl font-bold") do
        meditation_date = I18n.localize(Date.new(0, @meditation.month, @meditation.day), format: "%d %B")
        plain "#{meditation_date}. #{@meditation.title}"
      end
      div(class: "collapse-content text-justify") do
        @meditation.entry.each do |par|
          p(class: paragraph_class(type: par["type"])) { par["text"].html_safe }
        end
      end
    end
  end

  private

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
end
