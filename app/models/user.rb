class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :permission, :display_name

  validates_uniqueness_of :email
  validates_presence_of :name, :password, :email
  
  has_many :orders
  has_many :products, :through => :orders
end
