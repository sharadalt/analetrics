class RegisteredApplicationsController < ApplicationController
  
  after_action :verify_authorized, except: [:index, :downgrade]
  after_action :verify_policy_scoped, only: :index
  
  before_action :authenticate_user!
  
  def index
    @user = current_user
    @registered_applications = policy_scope(RegisteredApplication)
    @registered_application  = RegisteredApplication.new
    authorize @registered_application
  end

  def show
    @user = current_user
    @registered_applications = @user.registered_applications
    @registered_application  = @registered_applications.find(params[:id])
    authorize @registered_application
  end

  def new
    @user = current_user
    @registered_applications = @user.registered_applications
    @registered_application = RegisteredApplication.new
    @registered_application.user = @user
  end

  def create
    @user = current_user
    @registered_applications = @user.registered_applications
    @registered_application = @registered_applications.new
    @registered_application.name = params[:registered_application][:name]
    @registered_application.url  = params[:registered_application][:url]
    @registered_application.user = @user
    
    if @registered_application.save
      flash[:notice] = "registeredapplication  was saved."
      redirect_to registered_applications_path(@user)
    else
      flash.now[:alert] = "There was an error saving the application. Please try again."
      render :new
    end
  end

  def edit
    if @registered_application.user.admin? || @registered_application.user == current_user
      @registered_applications = RegisteredApplication.all
      @registered_application = RegisteredApplication.find(params[:id])
    end
  end
  
  def update
    if @registered_application.user.admin? || @registered_application.user == current_user
      @registered_applications = RegisteredApplication.all
      @registered_application = @registered_applications.find(params[:id])
      @registered_application.name = params[:registered_application][:name]
      @registered_application.url  = params[:registered_application][:url]
   
      if @registered_application.save
        flash[:notice] = "Registered_Application was updated."
        redirect_to registered_applications_path
      else
        flash[:error] = "There was an error saving the RegisteredApplication. Please try again."
        render :edit
      end
    end
  end
  
  def destroy
    @registered_application = RegisteredApplication.find(params[:id])
    authorize @registered_application

    if @registered_application.user.admin? || @registered_application.user == current_user
      if @registered_application.destroy
        flash[:notice] = "RegisteredApplication was deleted successfully."
          redirect_to registered_applications_path
      else
        flash[:error] = "There was an error deleting the RegisteredApplication."
        render :registered_applications_path
      end
    else
      flash[:error] = "The owner/admin has to delete it"
      redirect_to registered_applications_path
    end
  end
end
