# spot = Spot.find_by(name: '中尊寺')
# # spot.image.attach(io: File.open('app/javascript/images/noimage.png'), filename: 'noimage.png', content_type: 'image/png')
# spot.image.attach(io: File.open("app/javascript/images/#{spot.name}.jpg"), filename: "#{spot.name}.jpg", content_type: 'image/jpg')

Spot.all.each do |spot|
  if File.exist?("app/javascript/images/#{spot.name}.jpg")
    spot.image.attach(io: File.open("app/javascript/images/#{spot.name}.jpg"), filename: "#{spot.name}.jpg", content_type: 'image/jpg')
  else
    spot.image.attach(io: File.open('app/javascript/images/noimage.png'), filename: 'noimage.png', content_type: 'image/png')
  end
end
