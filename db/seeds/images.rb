Spot.all.each do |spot|
  spot.image.attach(io: File.open("app/javascript/images/spots/#{spot.name}.jpg"), filename: "#{spot.name}.jpg", content_type: 'image/jpg') if File.exist?("app/javascript/images/spots/#{spot.name}.jpg")
end

Statue.all.each do |statue|
  statue.image.attach(io: File.open("app/javascript/images/statues/#{statue.name}.png"), filename: "#{statue.name}.png", content_type: 'image/png') if File.exist?("app/javascript/images/statues/#{statue.name}.png")
end
