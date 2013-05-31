class ChangeQuestionText < ActiveRecord::Migration
  def change
    change_table :questions do |t|
      t.remove :text
      t.text :text
    end
  end
end
