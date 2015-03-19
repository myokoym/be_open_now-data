require "json"
require "pp"

def location(result)
  result["geometry"]["location"]
end

base_dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(base_dir)

json = JSON.parse(File.read("toshima-geo.json"))
p shops = json.collect {|shop| [shop["name"], location(shop["geo"]["results"][0])]}
locations = shops.collect {|shop| [shop[0], shop[1]["lat"], shop[1]["lng"]]}
locations.each do |location|
  puts "name: #{location[0]}"
  puts "lat: #{location[1]}"
  puts "lng: #{location[2]}"
end
