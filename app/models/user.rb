class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :display_name,
                  :email,
                  :full_name,
                  :password,
                  :password_confirmation
  validates_uniqueness_of :email
  validates_presence_of :full_name, :email, :password
  validates :display_name, :length => { :minimum => 2, :maximum => 32 }, :allow_blank => true

  has_many :orders
end
