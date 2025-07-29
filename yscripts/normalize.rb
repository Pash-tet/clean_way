require "json"

result = []
source = JSON.parse(File.read("db/seeds/daily_na.json"))
source.each do |s|
  d, m = s["date"].split(".").map(&:to_i)
  s["entry"][-1]["text"] = s["entry"][-1]["text"].sub("ТОЛЬКО СЕГОДНЯ", "<b>ТОЛЬКО СЕГОДНЯ</b>")
  result << {
    day: d,
    month: m,
    source: s["source"],
    title: s["title"],
    entry: s["entry"]
  }
end
f = File.open("daily_na.json", "wb")
f.write(JSON.pretty_generate(result))
f.close
