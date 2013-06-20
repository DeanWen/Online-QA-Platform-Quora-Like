class AdminController < ApplicationController
	before_action :verify

  def index
  	@users = User.order(:name)
  end

  def verify
  	if  current_user != User.find(4)
  		redirect_to root_path, alert: "Invaild Permission"
  	end
  end
  
end
