class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.integer :user_id
      
      t.timestamps
    end
  end
end
