class Trial < ActiveRecord::Base
  
  attr_accessible :user_id
  
  has_many :question_trials
  has_many :questions, :through => :question_trials
  has_many :jurors
  belongs_to :user
  
  def questions_count
    self.questions.count
  end
  
  def jurors_count
    self.jurors.count
  end
  
end
