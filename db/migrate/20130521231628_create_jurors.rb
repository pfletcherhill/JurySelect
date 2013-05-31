class CreateJurors < ActiveRecord::Migration
  def change
    create_table :jurors do |t|
      t.integer :number
      t.integer :trial_id
      t.text :notes
      
      t.timestamps
    end
  end
end
