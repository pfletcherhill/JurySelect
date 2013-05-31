class Juror < ActiveRecord::Base
  
  attr_accessor :question_id
  attr_accessible :trial_id, :number, :id, :created_at, :updated_at, :notes
  
  has_and_belongs_to_many :questions
  belongs_to :trial
  
  validates_presence_of :number
  validates_uniqueness_of :number, :scope => [:trial_id]
  
  default_scope order('number')
  
  def trial_questions
    trial = self.trial
    trial.questions
  end
  
end
