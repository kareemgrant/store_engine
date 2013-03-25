require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it 'renders the new template' do
      get 'new'
      expect(response).to render_template :new
    end
  end

  describe "POST '#create'" do
    context "user logs in with invalid information" do
      it "with passwords that do not match" do 
        post :create, user: {first_name: "Walter", last_name: "White", email: "breaking@bad.com", password: "meth", password_confirmation: "bob"}
        expect(response).to render_template :new
      end
    end

    context "user logs in with valid information" do
      it "with passwords that match" do
        post :create, user: {first_name: "Walter", last_name: "White", email: "breaking@bad.com", password: "meth", password_confirmation: "meth"}
        expect(response).to redirect_to root_path
      end
    end
  end
end
