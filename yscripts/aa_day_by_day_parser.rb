require "nokogiri"
require "open-uri"
require 'byebug'
require "json"

def format_p(p)
  p.text.gsub(/[\s\u00A0]{2,}/, ' ').gsub(/\n/, ' ').strip
end

first_content = Nokogiri::HTML(URI.open("https://aadaybyday.aa-book.net/category/yanvar/"))
ej = []

links = first_content.css("#menu-main a").map { |tab| tab.attributes["href"].value }[1..]

links.each do |link|
  doc = Nokogiri::HTML(URI.open(link))
  pages_count = doc.css(".page").count
  puts "Processing first page..."
  days_links = doc.css(".post-box-title a").map { |a| a.attributes["href"].value }

  pages_count.times do |page|
    page_link = "#{link}page/#{page + 2}"
    puts "Processing #{page_link}..."
    doc = Nokogiri::HTML(URI.open(page_link))
    days_links += doc.css(".post-box-title a").map { |a| a.attributes["href"].value }
  end

  days_links.each do |day_link|
    puts "Processing #{day_link}..."
    doc = Nokogiri::HTML(URI.open(day_link))
    p = doc.css(".entry p")
    ej << {
      title: Nokogiri::HTML.fragment(p.first.text).text,
      date:  doc.css(".tie-date").last.text[..4],
      source: "day_by_day_aa",
      entry: p[1..].map { |pa| { text: format_p(pa) } }
    }
  end
end

file = File.open("day_by_day_aa.json", "wb")
file.write(JSON.pretty_generate(ej))
file.close
