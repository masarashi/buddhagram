require 'csv'

CSV.foreach('db/seeds/statues.csv', headers: true) do |row|
  Statue.create(
    name: row['name'],
    ruby: row['ruby'],
    grade: row['grade'],
    content: row['content']
  )
end
