require 'spec_helper'

describe CategoriesController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it 'renders the new template' do
      get 'new'
      expect(response).to render_template :new
    end

    it "populates an array of categories" do

      category = Category.create(name: "Beards")

      get :index

      expect(assigns(:categories)).to match_array [category]
    end
  end

  describe "POST 'create'" do
    it "creates a new Jorge category" do
      post 'create', category: {name: "Jorge"}

      category = assigns(:category)
      # expect(response).to be_success
      expect(response).to redirect_to category_path(category)
    end
  end

  describe "GET 'edit'" do
    let(:category) { Category.create(name: "category")  }

    it "brings you to the edit page" do
      get 'edit', {id: category.id}
      expect(response).to render_template :edit
    end
  end

  describe "GET 'show'" do
    let(:category){Category.create name: "category"}

    it "assigns the requested category to category" do
      get :show, id: category
      expect(assigns(:category)).to eq category
    end

    it "renders the show template" do
      get :show, id: category
      expect(response).to render_template :show
    end

  end

  describe "PUT 'update'" do
    let(:category) {Category.create(name: "category") }

    context "When sent valid attributes" do
      it "redirects to the index view" do
        put 'update', {id: category.id}
        expect(response).to redirect_to categories_path
      end

    end

    # context "When sent invalid attributes" do

    #   let!(:category) {Category.create(name: "category")}

    #   it "renders edit view" do
    #     put :update, id: category, category: attributes_for(:category, name: "anything")
    #     # category.reload
    #     # expect(category.name).to eq("anything")
    #     expect(response).to render_template :edit
    #   end

    # end
  end

  describe "DESTROY 'delete'" do
    let!(:category) {Category.create(name: "Abdul")}

    it "deletes the category" do
      delete :destroy, id: category
      expect(response).to redirect_to categories_path
      #expect{delete :destroy, id: category}.to change(Category, :count).by(-1)
    end
  end



end
