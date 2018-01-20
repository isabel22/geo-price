class CoursesController < ApplicationController
  def index
    courses_options
  end

  def display_info
    courses_options
    selected_course = params[:course]
    course = JSON.parse(CareerFoundry::Courses.get_details(selected_course))
    @title = course["slug"].titleize
    @start_dates = course["start_dates"]
    current_region = CareerFoundry::Courses.region
    price = course["price"][current_region]
    @course_link = "http://www.careerfoundry.com/en/courses/#{selected_course}"

    learn_description = 'learn' if @title.downcase.match('become').nil?
    @description = "In only #{price['cycles']} cycles you will #{learn_description} #{@title.downcase} for only #{price['total']}"
  end
end

private

def courses_options
  all_courses = JSON.parse(CareerFoundry::Courses.get_all)
  @course_options = []

  all_courses['courses'].keys.each do |course_slug|
    @course_options << [course_slug.titleize, course_slug]
  end
end
