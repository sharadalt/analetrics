class RegisteredApplicationPolicy < ApplicationPolicy
  
  class Scope 
    attr_reader :user, :scope
    
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    def resolve
      registered_applications = []
      if user.role == 'admin'
        registered_applications = scope.all # if the user is an admin, show them all the registered_applications
      else # this is the lowly standard user
        all_registered_applications = scope.all
        registered_applications = []
        all_registered_applications.each do |regapp|
          if regapp.user == user
            registered_applications << regapp #only show standard users their own registered_applications
          end
        end
      end
      registered_applications # return the registered_applications array we've built up
    end
  end
  
  attr_reader :user, :registered_application

  def initialize(user, registered_application)
    @user = user
    @wiki = registered_application
  end

  def update?
    user.present?
  end
  
  def index?
    true
  end
  
  def show?
    user.present?
  end
  
  def new?
    user.present?
  end
  
  def create?
    user.present?
  end
  
  def edit?
    user.present?
  end
  
  def destroy?
    user.present?
  end
  
  def downgrade?
    true
  end
  
end
