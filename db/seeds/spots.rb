require 'csv'

CSV.foreach('db/seeds/spots.csv', headers: true) do |row|
  Spot.create(
    name: row['name'],
    country: row['country'],
    state: row['state'],
    address: row['address'],
    latitude: row['latitude'],
    longitude: row['longitude'],
    content: row['content']
  )
end
