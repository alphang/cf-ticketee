require 'spec_helper'

feature 'Deleting Project' do

  scenario "Deleting a project" do
    Factory(:project, :name => "TextMate 2")
    visit "/"
    click_link "TextMate 2"
    click_link "Delete Project"
    #Capybara doesn't do JavaScript so it won't have to confirm
    page.should have_content("Project has been deleted.")

    visit "/"
    page.should_not have_content("TextMate 2")
  end

end
