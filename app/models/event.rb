class Event < ActiveRecord::Base
  
  belongs_to :registered_application
  
  validates :registered_application_id, presence: true
  
  validates_presence_of :name
  
end
