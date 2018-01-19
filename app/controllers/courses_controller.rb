class CoursesController < ApplicationController
  def index
    all_courses = JSON.parse(CareerFoundry::Courses.get_all)
    @course_options = []

    all_courses['courses'].keys.each do |course_slug|
      @course_options << [course_slug.titleize, course_slug]
    end
  end
end
