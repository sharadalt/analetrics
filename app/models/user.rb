class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
         
  has_many :registered_applications, :dependent => :destroy
  
  enum role: [:standard, :admin]
  before_save {self.role ||= :standard }
  
end
