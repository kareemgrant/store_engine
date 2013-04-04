class Order < ActiveRecord::Base
  attr_accessible :total_price, :user_id

  has_many :line_items
  has_many :events, class_name: "OrderEvent"

  belongs_to :user
  validates_presence_of :total_price, :user_id

  def add_line_items(cart)
    cart.line_items.each do |li|
      li.cart_id = nil
      line_items << li
    end
  end

  def total_price_from_cart(cart)
    self.total_price = cart.total_price
    total_price
  end

  def add_quantity(line_item)
    current_item = line_items.find(line_item)
    current_item.quantity += 1
    current_item.save
  end

  def decrease_quantity(line_item)
    current_item = line_items.find(line_item)
    current_item.quantity -= 1
    current_item.save
  end

  STATUSES = %w[pending cancelled paid shipped returned]
  delegate :pending?, :cancelled?, :paid?, :shipped?, :returned?, to: :current_status

  def self.pending_orders
    joins(:events).merge OrderEvent.with_last_status("pending")
  end

  def current_status
    (events.last.try(:status) || STATUSES.first).inquiry
  end

  # def purchase(valid_payment = true)
  #   if incomplete?
  #     # process purchase ...
  #     events.create! status: "open" if valid_payment
  #   end
  # end

  def paid
    events.create! status: "paid" if pending?
  end

  def cancel
    events.create! status: "cancelled" if pending?
  end

  def return
    events.create! status: "returned" if shipped?
  end

  def ship
    events.create! status: "shipped" if paid?
  end
end
