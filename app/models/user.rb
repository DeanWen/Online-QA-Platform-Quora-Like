class User < ActiveRecord::Base
	after_destroy :ensure_an_admin_remains
	
	validate :name, presence: true, uniqueness: true
  	has_secure_password

  def to_s
  	name
  end

  private
	def ensure_an_admin_remains
		if User.count.zero?
		raise "Can't delete last user"
		end
	end 
end
