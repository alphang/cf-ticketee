require 'spec_helper'

feature "Editing Projects" do

  before do
    sign_in_as!(Factory(:admin_user))
    Factory.create(:project, :name => "TextMate 2")
    visit "/"
    click_link "TextMate 2"
    click_link "Edit Project"
  end

  scenario "Updating a project" do
    #binding.pry
    fill_in "name", :with => "TextMate 2 beta"
    click_button "Update Project"
    page.should have_content("Project has been updated.")
  end

  scenario "Updating a project wiht invalid attributes is bad" do
    fill_in "name", :with => ""
    click_button "Update Project"
    page.should have_content("Project has not been updated.")
  end

end
