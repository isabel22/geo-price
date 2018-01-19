module CareerFoundry
  class Courses
    require 'rest_client'

    def self.get_all
      Rails.cache.fetch('career_foundry/courses', expires_in: 5.minutes) do
        fetch_all
      end
    end

    def self.get_details(course)
      fetch_one(course)
    end

    def self.region(ip = nil)
      ip_url = "http://ip-api.com/json/#{ip}"
      ip_url = "http://ip-api.com/json" unless ip.present?

      response = RestClient.get(ip_url)
      if response.code == 200
        json_response = JSON(response.body)
        region_name = json_response["regionName"]
        timezone = json_response["timezone"]
        if region_name == 'London'
          return 'UK'
        elsif timezone.downcase.match('europe').present?
          return 'EU'
        else
          return 'NA'
        end
      else
        raise Exception.new("CareerFoundryCourses.region: Could not get timezone")
      end
      return 'EU'
    end

    private

    def self.fetch_all
      courses_url = 'https://careerfoundry.com/en/api/courses'
      response = RestClient.get(courses_url)
      if response.code == 200
        response.body
      else
        raise Exception.new("CareerFoundryCourses.fetch_all: Could not get courses")
      end
    end

    def self.fetch_one(course)
      course_url = "https://careerfoundry.com/en/api/courses/#{course}"
      response = RestClient.get(course_url)
      if response.code == 200
        response.body
      else
        raise Exception.new("CareerFoundryCourses.fetch_one: Could not get information for #{course}")
      end
    end
  end
end
