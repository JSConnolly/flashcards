require 'CSV'

# capitals = Deck.create(name: "State Capitals")
# capital_data = CSV.read("public/capitals.csv")
# p capital_data.shift
# capital_data.each do |row|
#   Card.create(question: row[0], answer: row[1], deck_id: capitals.id)
# end

# jQuery_e_methods = Deck.create(name: "jQuery Event Methods")

# method_defs_parsed = CSV.read("public/jQuery.csv")
# method_defs_parsed.each do |row|
#   Card.create(question: row[1], answer: row[0], deck_id: jQuery_e_methods.id)
# end

test_deck = Deck.create( name: "Test Deck" )

Card.create( question: 'test q1', answer: 'answer a1', deck_id: test_deck.id)
Card.create( question: 'test q2', answer: 'answer a2', deck_id: test_deck.id)
Card.create( question: 'test q3', answer: 'answer a3', deck_id: test_deck.id)
