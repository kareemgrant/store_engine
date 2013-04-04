require 'spec_helper'

describe Order do

  context "is a valid order" do
    let!(:order){Order.create(total_price: 45, user_id: 1)}
    it "is valid" do
      expect(order).to be_valid
    end
  end

  context "is missing total price" do
    let!(:order){Order.create(user_id: 1)}
    it "is not valid" do
      expect(order).to be_invalid
    end
  end

  context "is missing user id" do
    let!(:order){Order.create(total_price: 45)}
    it "is not valid" do
      expect(order).to be_invalid
    end
  end

  it "extrapolates the total price from the cart" do
    cart = stub(:total_price => 45)
    order = Order.new
    expect(order.total_price_from_cart(cart)).to eq 45
  end

  describe "incrementing and decrementing" do
    before do
      cart = Cart.create
      @line_item = LineItem.create(product_id: 10, cart_id: cart.id, quantity: 3)
      @order = Order.create(user_id: 1)
      @order.line_items = []
      @order.line_items << @line_item
    end

    it "increases the quantity of a line item" do
      @order.add_quantity(@line_item)
      expect(@order.line_items.find(@line_item).quantity).to eq 4
    end

    it "decreases the quantity of a line item" do
      @order.decrease_quantity(@line_item)
      expect(@order.line_items.find(@line_item).quantity).to eq 2
    end
  end
end
