class User < ActiveRecord::Base
  
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  before_save :encrypt_password    
	
  validates_presence_of :name  
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password_confirmation, :on => :create
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password  
	
	has_many :trials
	has_many :questions
	
  def encrypt_password  
    if password.present?  
  		self.password_salt = BCrypt::Engine.generate_salt  
  		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)  
  	end  
  end 
   
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
end
