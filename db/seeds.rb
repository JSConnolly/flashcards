require 'CSV'

capitals = Deck.create(name: "State Capitals")
capital_data = CSV.read("public/capitals.csv")
p capital_data.shift
capital_data.each do |row|
  Card.create(question: row[0], answer: row[1], deck_id: capitals.id)
end
