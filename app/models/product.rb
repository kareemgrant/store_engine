class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price_in_dollars, :active, :category_ids, :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at
  extend FriendlyId
  friendly_id :title, use: :slugged


  validates_uniqueness_of :title
  validates_presence_of :title, :description, :price, :price_in_dollars
  validates :price, :numericality => {:greater_than => 001, :message => "price must be greater than zero"}
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :line_items
  has_attached_file :photo #,
    # :storage => :s3,
    # :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
    # :path => ":attachment/:id/:style.:extension",
    # :bucket => "store-engine"




  before_destroy :ensure_not_referenced_by_any_line_item

  def active?
    if self.active == false
      "retired"
    else
      "active"
    end
  end

  def to_s
    title
  end

  def price_in_dollars
    price.to_d / 100 if price
  end

  def price_in_dollars=(dollars)
    self.price = dollars.to_d * 100.0
  end

  def categories_list
    self.categories.join(", ")
  end


  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      true
    else
      errors.add(:base, 'Line Items present')
      false
    end
  end
end
