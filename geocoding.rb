require "yaml"
require "open-uri"
require "json"
require "erb"

input_path = "toshima.yaml"
output_path = "#{File.basename(input_path, ".yaml")}-geo.json"

shops = YAML.load(File.read(input_path))

latlngs = []
shops.each do |shop|
  latlng = {}
  latlng["name"] = shop["name"]
  latlng["address"] = shop["address"]
  encoded_address = ERB::Util.url_encode(shop["address"])
  url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{encoded_address}"
  latlng["geo"] = JSON.parse(open(url).read)
  latlngs << latlng
  sleep 0.5
end

File.write(output_path, JSON.generate(latlngs))
