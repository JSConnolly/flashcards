class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :round_id
      t.integer :card_id, :null => false
      t.string :guess, :null => false
      t.string :correct
      t.timestamps
    end
  end
end
