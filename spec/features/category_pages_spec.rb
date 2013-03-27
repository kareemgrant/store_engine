require 'spec_helper'
require 'capybara/rspec'

describe "Category pages" do
  subject { page }

  
  describe "Creating a category" do
    before { visit new_category_path }

    describe "with invalid information" do

      it "should not create a new category" do
        expect { click_button "submit" }.not_to change(Category, :count)
      end

      it "should display error message" do
        click_button "submit"
        page.should have_content("prohibited")
      end

    end

    describe "with valid information" do

      it "should increase Category count" do
        fill_in "Name", with: "Anything"
        expect { click_button "submit"}.to change(Category, :count)
      end

    end

  end

  describe "Viewing list of categories" do

    let!(:category){ Category.create(name: "Beards")}

    before { visit categories_path }
      
    describe "content on index page" do
      
      it "should have delete links for each category listed" do
        page.should have_content("Beards")
        page.should have_link("Delete", href: category_path(category))
      end

      it "should have an edit link on the page" do
        page.should have_link("Edit", href: edit_category_path(category))
      end
    end

  end

  describe "When editing a category" do

    let!(:category){Category.create(name: "Capybara")}

    before { visit edit_category_path(category) }

    it "successfully updates the category" do
      fill_in "Name", with: "Kareem"
      click_button "submit"
      page.should have_content("Kareem")
    end
  end


  describe "Deletes category" do

    let!(:category){Category.create(name: "Capybara")}

    before { visit categories_path }
    
    it "successfully deletes the category" do
      page.click_link(href: category_path(category)) 
      page.should_not have_link("Delete", href: category_path(category))
    end
  end
  
end
