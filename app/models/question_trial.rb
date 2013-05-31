class QuestionTrial < ActiveRecord::Base
  
  belongs_to :trial
  belongs_to :question
  
  validates_uniqueness_of :question_id, :scope => ["trial_id"]

end
