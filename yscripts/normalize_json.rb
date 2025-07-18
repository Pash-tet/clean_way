require "nokogiri"
require "open-uri"
require 'byebug'
require "json"

days = JSON.parse(File.read("db/seeds/ej_na.json"))

ej = days.values.flatten.map { |m| m["days"] }.flatten.map do |day|
  params = day.slice("quote", "title", "text")
  params["quote_source"] = day["source_quote"]
  params["day"], params["month"] = day["date"].split(".").map(&:to_i)
  params["summary"] = day["jtf"]
  params[:source] = "na"
  params
end

file = File.open("na.json", "wb")
file.write(JSON.pretty_generate(ej))
file.close