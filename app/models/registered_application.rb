class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  
  validates :user_id, presence: true
  
  validates_presence_of :name
  validates_presence_of :url
end
