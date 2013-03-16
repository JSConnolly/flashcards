require 'CSV'

# capitals = Deck.create(name: "State Capitals")
# capital_data = CSV.read("public/capitals.csv")
# p capital_data.shift
# capital_data.each do |row|
#   Card.create(question: row[0], answer: row[1], deck_id: capitals.id)
# end

jQuery_e_methods = Deck.create(name: "jQuery Event Methods")

method_defs_parsed = CSV.read("public/jQuery.csv")
method_defs_parsed.each do |row|
  Card.create(question: row[1], answer: row[0], deck_id: jQuery_e_methods.id)
end
