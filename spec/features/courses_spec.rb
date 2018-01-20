require 'spec_helper'

feature 'Courses' do
  def index
    expect(page).to have_content('CareerFoundry')
    expect(page).to have_content('UX, UI and Web Development Courses Online')
    expect(page).to have_content('Learn in-demand skills today and change your career')
    expect(page).to have_content('Select the course that will change your career')
    expect(page).to have_css('custom-select')
    select2('Ux Fundamentals', '.course')
    click_button 'Go'
  end
end
