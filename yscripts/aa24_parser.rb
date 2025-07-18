require "nokogiri"
require "open-uri"
require 'byebug'
require "json"

def format_p(p)
  p.text.gsub(/[\s\u00A0]{2,}/, ' ').gsub(/\n/, ' ').strip
end

first_content = Nokogiri::HTML(URI.open("https://aa24hours.aa-book.net/category/yanvar/"))
ej = []

links = first_content.css("#menu-main a").map { |tab| tab.attributes["href"].value }[1..]

links.each do |link|
  doc = Nokogiri::HTML(URI.open(link))
  pages_count = doc.css(".page").count
  puts "Processing first page..."
  days_links = doc.css("a.more-link").map { |a| a.attributes["href"].value }

  pages_count.times do |page|
    page_link = "#{link}page/#{page + 2}"
    puts "Processing #{page_link}..."
    doc = Nokogiri::HTML(URI.open(page_link))
    days_links += doc.css(".post-box-title a").map { |a| a.attributes["href"].value }
  end

  days_links.each do |day_link|
    puts "Processing #{day_link}..."
    doc = Nokogiri::HTML(URI.open(day_link))
    text = []
    doc.css(".entry").children.each do |p|
      next unless %w[h3 p].include?(p.name)
      par = {text: p.text}
      par[:type] = "heading" if p.name == "h3"
      text << par
    end
    ej << {
      title: nil,
      date:  doc.css(".tie-date").last.text[..4],
      entry: text,
      source: "aa24"
    }
  end
end

file = File.open("aa24hours.json", "wb")
file.write(JSON.pretty_generate(ej))
file.close
