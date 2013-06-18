class User < ActiveRecord::Base
	include Rails.application.routes.url_helpers
	
	after_destroy :ensure_an_admin_remains
	
	validate :name, presence: true, uniqueness: true
  	has_secure_password

  def to_s
  	name
  end

  def base_url
    user_path(self)
  end

  private
	def ensure_an_admin_remains
		if User.count.zero?
		raise "Can't delete last user"
		end
	end 
end
