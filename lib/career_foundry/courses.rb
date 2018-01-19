module CareerFoundry
  class Courses
    require 'rest_client'

    def self.get_all
      Rails.cache.fetch('career_foundry/courses', expires_in: 5.minutes) do
        fetch_all
      end
    end

    private

    def self.fetch_all
      courses_url = 'https://careerfoundry.com/en/api/courses'
      response = RestClient.get(courses_url)
      if response.code == 200
        response.body
      else
        raise Exception.new("CareerFoundryCourses.fetch_all: Could not get courses ")
      end
    end
  end
end
