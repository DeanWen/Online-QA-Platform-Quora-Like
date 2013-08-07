class Post < ActiveRecord::Base
  validates :name,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 5 }
 
  has_many :comments, :dependent => :destroy
  has_many :tags
  belongs_to :user
  accepts_nested_attributes_for :tags, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  scope :user_id, Proc.new { |user_id|
    where(:user_id => user_id) if user_id.to_i.nonzero?
  }

def previous
	Post.limit(1).order("id ASC").where("id > ?",id).first
end

def next
	Post.limit(1).order("id DESC").where("id < ?",id).first
	
end
end