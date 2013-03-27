require 'spec_helper'

describe Product do

  context "missing title" do
    let(:product){Product.new description: "ipsum mormon", price: 12.95}

    it "is invalid" do
      expect(product).to be_invalid
    end

    it "has errors" do
      expect(product).to have(1).errors_on(:title)
    end
  end
  context "missing description" do
    let(:product){Product.new title: "cheeseburgers", price: 99.95}

    it "is invalid " do
      expect(product).to be_invalid
    end

    it "has errors" do
      expect(product).to have(1).errors_on(:description)
    end
  end
  
  context "missing price" do
    let(:product){Product.new title: "cheeseburgers", description: "I love cheesburgers"}

    it "is invalid" do
      expect(product).to be_invalid
    end

    it "has errors" do
      expect(product).to have(1).errors_on(:price)
    end
  end

  context "happy path" do
    let(:product){Product.new title: "mormon cheeseburgers", description: "ipsum mormon", price: 10.13}

    it "is valid" do
      expect(product).to be_valid
    end

    it "has 0 errors" do
      expect(product).to have(0).errors
    end
  end

  context "validates uniqueness" do
    let!(:product){Product.create title: "mormon cheeseburgers", description: "ipsum mormon", price: 10.13}
    let!(:product2){Product.create title: "mormon cheeseburgers", description: "ipsum mormon", price: 10.13}

    it "validates uniqueness of title" do
      expect(product2).to have(1).error
    end
  end
end
