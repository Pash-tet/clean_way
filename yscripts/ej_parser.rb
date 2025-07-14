require "nokogiri"
require "open-uri"
require 'byebug'
require "json"

def format_p(p)
  p.text.gsub(/[\s\u00A0]{2,}/, ' ').gsub(/\n/, ' ').strip
end

first_content = Nokogiri::HTML(URI.open("https://nadiary.aa-book.net/na/yanvar/"))
ej = {}

first_content.css("#menu-main a").each do |tab|
  link = tab.attributes["href"].value
  key = link.split("/").last
  ej[key] = {
    name: tab.children.text,
    link: link,
    days: []
  }
end

ej.keys.each do |key|
  month = ej[key]

  doc = Nokogiri::HTML(URI.open(month[:link]))
  pages_count = doc.css(".page").count
  puts "Processing first page..."
  days_links = doc.css(".post-box-title a").map { |a| a.attributes["href"].value }

  pages_count.times do |page|
    page_link = "#{month[:link]}page/#{page + 2}"
    puts "Processing #{page_link}..."
    doc = Nokogiri::HTML(URI.open(page_link))
    days_links += doc.css(".post-box-title a").map { |a| a.attributes["href"].value }
  end

  days_links.each do |day_link|
    puts "Processing #{day_link}..."
    doc = Nokogiri::HTML(URI.open(day_link))
    p = doc.css(".entry p")
    month[:days] << {
      quote: format_p(p.first),
      title: doc.css("h1.entry-title span").text.split(".").map(&:strip)[1..].join("."),
      source_quote: format_p(p[1]),
      date:  doc.css(".tie-date").last.text[..4],
      text: p[2..-2].map { |pa|format_p(pa)}.join(" "),
      jtf: format_p(p[-1])
    }
  end
end

file = File.open("ej.json", "wb")
file.write(JSON.pretty_generate(ej))
file.close
