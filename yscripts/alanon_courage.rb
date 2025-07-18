require "nokogiri"
require "open-uri"
require 'byebug'
require "json"

def strip_spaces(str)
  str.gsub(/[ \u00A0]{2,}/, ' ').gsub(/\n/, ' ').strip
end

def blank?(str)
  str.match?(/\A[ \u00A0]*\z/)
end

BASE_LINK = "https://mmalanon.aa-book.net/"

MONTHS = {
  yanvarya: 31,
  fevralya: 29,
  marta: 31,
  aprelya: 30,
  maya: 31,
  iyunya: 30,
  iyulya: 31,
  avgusta: 31,
  sentyabrya: 30,
  oktyabrya: 31,
  noyabrya: 30,
  dekabrya: 31
}

ej = []

MONTHS.each do |month, days_count|
  (1..days_count).each do |day|
    link = "#{BASE_LINK}#{day}-#{month}"
    puts "Processing #{link} ..."
    doc = Nokogiri::HTML(URI.open(link))
    entry = doc.css(".entry p")
    paragraphs = []
    main = entry[0..-3]
    main.each do |p|
      next if blank?(p.text)

      par = { text: strip_spaces(p.text) }
      par[:type] = :heading if p.children.first.name == "strong"
      paragraphs << par
    end
    paragraphs << { text: strip_spaces(entry[-2].text), type: :quote }
    paragraphs << { text: strip_spaces(entry[-1].text), type: :quote_source }

    ej << {
      title: nil,
      date:  doc.css(".tie-date").last.text[..4],
      source: "courage_alanon",
      entry: paragraphs
    }
  end

rescue
  break
end

# links = first_content.css(".menu a").map { |tab| tab.attributes["href"].value }[1..]
#
# links.each do |link|
#
#   pages_count = doc.css(".page").count
#   puts "Processing first page..."
#   days_links = doc.css(".post-box-title a").map { |a| a.attributes["href"].value }
#
#   pages_count.times do |page|
#     page_link = "#{link}page/#{page + 2}"
#
#     doc = Nokogiri::HTML(URI.open(page_link))
#     days_links += doc.css(".post-box-title a").map { |a| a.attributes["href"].value }
#   end
#
#   days_links.each do |day_link|
#     puts "Processing #{day_link}..."
#     doc = Nokogiri::HTML(URI.open(day_link))
#     p = doc.css(".entry p")
#     text = []
#     # text << {text: format_p(p.first), type: :quote}
#     # text << {text: format_p(p[1]), type: :quote_source}
#     # text +=  p[2..].map { |pa| { text: format_p(pa) } }
#     byebug
#     ej << {
#       title: nil,
#       date:  doc.css(".tie-date").last.text[..4],
#       source: "daily_na",
#       entry: text
#     }
#     break
#   end
#   break
# end

file = File.open("alanon_courage.json", "wb")
file.write(JSON.pretty_generate(ej))
file.close
