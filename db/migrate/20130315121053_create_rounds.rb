class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :user_id
      t.integer :deck_id, :null => false
      t.integer :num_correct, :default => 0
      t.integer :num_incorrect, :default => 0
      t.timestamps
    end
  end
end
