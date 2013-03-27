class Product < ActiveRecord::Base
   attr_accessible :title, :description, :price

   validates_uniqueness_of :title
   validates_presence_of :title, :description, :price
end
