class Question < ActiveRecord::Base
  
  attr_accessible :user_id, :text, :abbreviation
  
  validates_presence_of :text
  validates_presence_of :abbreviation
  validates_uniqueness_of :abbreviation, :scope => ["user_id"]
  
  has_many :question_trials
  has_many :trials, :through => :question_trials
  belongs_to :user
  has_and_belongs_to_many :jurors
  
  def trial_jurors (trial_id)
    self.jurors.where(:trial_id => trial_id)
  end
  
end
