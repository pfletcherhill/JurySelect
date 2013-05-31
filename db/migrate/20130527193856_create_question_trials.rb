class CreateQuestionTrials < ActiveRecord::Migration
  def change
    create_table :question_trials do |t|
      t.integer :question_id
      t.integer :trial_id
      t.boolean :complete
    end
  end
end
