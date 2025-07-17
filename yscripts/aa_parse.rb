require "nokogiri"
require "open-uri"
require 'byebug'
require "json"

dates_hash = {
  "01" => 31,
  "02" => 29,
  "03" => 31,
  "04" => 30,
  "05" => 31,
  "06" => 30,
  "07" => 31,
  "08" => 31,
  "09" => 30,
  10 => 31,
  11 => 30,
  12 => 31
}
def format_p(p)
  p.text.gsub(/[\s\u00A0]{2,}/, ' ').gsub(/\n/, ' ').strip
end

ej = []
base_url = "https://mos-nach.ru/thinks/daily_"
dates_hash.each do |month, days_count|
  days_count.times do |i|
    day = (i + 1).to_s.size == 1 ? "0#{i + 1}" : (i + 1).to_s
    url = "#{base_url}#{day}-#{month}.html"
    puts "Processing #{url}..."
    doc = Nokogiri::HTML(URI.open(url))
    p = doc.css(".html-ezh-raa > p").map { |pa| format_p(pa) }
    entry = [{text: p.first, type: :quote}, {text: p[1], type: :quote_source}]
    entry += p[2..].map { |t| {text: t} }

    ej << {
      date: "#{day}.#{month}",
      title: doc.css(".html-ezh-raa > h2").text.gsub(/[\s\u00A0]{2,}/, ' ').gsub(/\n/, ' ').strip.capitalize,
      entry: entry,
      source: "daily_aa"
    }
  end
end

file = File.open("aa_daily.json", "wb")
file.write(JSON.pretty_generate(ej))
file.close