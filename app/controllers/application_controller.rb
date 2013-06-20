class ApplicationController < ActionController::Base
  before_action :authorize,:current_user
  protect_from_forgery
 
  private
  # def authenticate
  #   authenticate_or_request_with_http_basic do |user_name, password|
  #     user_name == 'admin' && password == 'password'
  #   end
  # end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authorize
  	unless current_user
  		redirect_to login_url, notice: "Please log in" 		
  	end
  end 
end