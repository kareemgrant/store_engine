require 'spec_helper'

describe User do

  context "when there is no first name" do
    let(:user){ User.new last_name: "Grant", email: "s@s.com", password: "yes" }

    it "is invalid" do
      expect(user).to be_invalid
    end

    it "has errors" do
      expect(user).to have(1).errors_on(:first_name)
    end
  end

  context "when there is no last name" do
    let(:user){ User.new first_name: "Kareem", email: "s@s.com", password: "yes"}

    it "is invalid" do
      expect(user).to be_invalid
    end

    it "has errors" do
      expect(user).to have(1).errors_on(:last_name)
    end
  end

  context "when there is no email" do
    let(:user){ User.new first_name: "Kareem", last_name: "Grant", password: "yes" }

    it "is invalid" do
      expect(user).to be_invalid
    end

    it "has errors" do
      expect(user).to have(1).errors_on(:email)
    end
  end

  context "when there is no password" do
    let(:user){ User.new first_name: "Kareem", last_name: "Grant", email: "s@s.com" }

    it "is invalid" do
      expect(user).to be_invalid
    end

    it "has errors" do
      expect(user).to have(1).errors_on(:password)
    end
  end

  context "happy path" do
    let(:user){ User.new first_name: "Kareem", last_name: "Grant", email: "s@s.com", password: "yes" }

    it "is valid" do
      expect(user).to be_valid
    end

    it "has no errors" do
      expect(user).to have(0).errors
    end
  end

  context "validate unique email" do
  
    before(:each) do
      @user1 = User.create first_name: "Paul", last_name: "Blackwell", email: "s@s.com", password: "yolo"
      @user2 = User.create first_name: "Paul", last_name: "Wall", email: "s@s.com", password: "hello"
    end
    
    it "is invalid" do
      expect(@user2).to be_invalid
    end

    it "has an error" do
      expect(@user2).to have(1).errors
    end
  end
end
