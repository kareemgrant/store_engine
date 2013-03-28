class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price_in_dollars_and_cents, :active, :category_ids

  validates_uniqueness_of :title
  validates_presence_of :title, :description, :price
  validates :price, :numericality => {:greater_than => 001, :message => "price must be greater than zero"}
  has_many :product_categories
  has_many :categories, through: :product_categories

  def active?
    if self.active == false
      "retired"
    else
      "active"
    end
  end

  def price_in_dollars_and_cents
    "%.2f" % (price.to_i / 100.0)
  end

  def price_in_dollars_and_cents=(value)
    self.price = value.to_f * 100.0
  end

  def categories_list
    self.categories.join(", ")
  end
end