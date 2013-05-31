class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.string :abbreviation
      t.integer :user_id
    end
    create_table :jurors_questions do |t|
      t.integer :juror_id
      t.integer :question_id
    end
  end
end
