require 'httparty'
require 'json'

class ReloadController < ApplicationController
    before_action :authenticate_admin!

    include HTTParty
    base_uri 'https://content.osu.edu/v2/classes/search'
  
    def index
      @url = 'https://content.osu.edu/v2/classes/search'
    end
  
  
    def update
        get_url_params
        load_data
        # Redirect to the index page to generate a clean URL without parameters
        redirect_to courses_path, notice: "Database reload successful."
    end

    # DELETE database
    def delete_all
        Section.delete_all
        Course.delete_all

        redirect_to courses_path, notice: "Courses and Sections deleted successfully."
    end

    def load_data
        # Initialize the DataLoader and load courses, sections, instructors into the database
        load_courses
        load_instructors_sections
    end
  
    private
  
    def get_url_params
        @q = params[:q]
        @term = params[:term]
        @campus = params[:campus]
        @academic_career = params[:"academic-career"]
        @subject = "cse"
        
        # Build the query hash based on params
        @query_params = {
            q: @q,
            term: @term,
            campus: @campus,
            "academic-career": @academic_career,
            subject: @subject,
            p: 1
        }
        
        # Remove nil or empty values from the query_params
        @query_params.reject! { |_, v| v.nil? || (v.respond_to?(:empty?) ? v.empty? : false) }
        puts "Valid params: "
        puts @query_params
    end

    # fetch and parse JSON data from API
    def fetch_courses(page)
        @query_params[:p] = page
        full_url = "#{self.class.base_uri}?#{URI.encode_www_form(@query_params)}"
        puts "Fetching data from: #{full_url}"
        response = self.class.get('', query: @query_params)
        return [] unless response.success?
        JSON.parse(response.body)['data'] || []
    end

    # loop through every thing in the API to load courses into database
    def load_courses
        page = 1
        loop do
            response = fetch_courses(page)
            ## need to reduce load time for page? comment out the below code
            # if page == 2
            #     break
            # end
                
            if response['courses'].empty?
                if page != 1
                    puts "Course information was loaded into database!"
                    puts "End of page reached."
                else
                    puts "Error: The API request was not successful."
                end
                break
            end
            puts "Current Page (Courses): #{page}."
            save_courses_to_database(response['courses'])
            page += 1
        end
        puts "Total Page (Courses): #{page}."
    end

    # loop through every thing in the API to load instructor's info and section into database
    def load_instructors_sections
        page = 1
        loop do
            response = fetch_courses(page)
            ## need to reduce load time for page? comment out the below code
            # if page == 2
            #     break
            # end
            if response.empty?
                if page != 1
                    puts "Section, Instructor information was loaded into database!"
                    puts "End of page reached."
                else
                    puts "Error: The API request was not successful."
                end
                break
            end
            puts "Current Page (Instructor, Section): #{page}."
            save_instructors_sections_to_database(response['courses'])
            page += 1
        end
        puts "Total Page (Instructor, Section): #{page}."
    end

    # save courses into database
    def save_courses_to_database(courses)
        # create or update Course records
        courses.each do |course_data|
            Course.find_or_create_by(
                course_id: course_data['course']['courseId'],
                course_name: course_data['course']['title'],
                credit_hour: course_data['course']['maxUnits'],
                academic_career: course_data['course']['academicCareer'],
                campus: course_data['course']['campus'],
                term: course_data['course']['term'],
                course_discription: course_data['course']['description'],
                catalog_number: course_data['course']['catalogNumber']
            )
        end
    end

    # save instructors and sections into database
    def save_instructors_sections_to_database(courses)
        # create or update Course records
        courses.each do |course_data|
            # load instructor data into database
            sections = course_data['sections']
            save_instructors_to_database(sections)
            # load section data into database
            save_sections_to_database(sections)
        end
    end

    # save instructors into database
    def save_instructors_to_database(sections)
        sections.each do |section_data|
            instructor_info = section_data['meetings'][0]['instructors'][0]
            fullName = instructor_info['displayName']

            # if no instructor for this section, ignore this section
            if fullName.nil?
                next
            else # get the full name
                fullName = fullName.split(" ")
            end

            fname = fullName[0]
            lname = fullName[1]
            # save the full name to database
            if fullName.length > 2
                lname += " " + fullName[2]
            elsif fullName.empty?
                puts "Name is Empty."
            end

            # create a user account for this instructor with instructor role, default password is 123456
            if User.exists?(email: instructor_info['email']) || instructor_info['email'].nil?
                next
            else
                user1 = User.create(
                    email: instructor_info['email'],
                    password: "123456"
                )   
                
                Person.create(
                    email: instructor_info['email'],
                    first_name: fname,
                    last_name: lname,
                    role: "instructor",
                    user_id: user1.id
                )

                Instructor.create(
                    faculty_email: instructor_info['email']
                )
            end
        end
    end

    # save sections into database
    def save_sections_to_database(sections)
        # create or update Section records
        sections.each do |section_data|

            # s_time = section_data['meetings'][0]['startTime']
            # e_time = section_data['meetings'][0]['endTime']
            # Parse the time string into a Time object
            # s_time = Time.strptime(s_time, "%I:%M %p").strftime("%H:%M:%S") unless s_time.nil?
            # e_time = Time.strptime(e_time, "%I:%M %p").strftime("%H:%M:%S") unless e_time.nil?

            Section.find_or_create_by(
                section_id: section_data['section'],
                start_time: section_data['meetings'][0]['startTime'],
                end_time: section_data['meetings'][0]['endTime'],
                weekday: weekday_getter(section_data),
                start_date: section_data['startDate'],
                end_date: section_data['endDate'],
                semester_code: section_data['term'],
                campus: section_data['campus'],
                faculty_email: section_data['meetings'][0]['instructors'][0]['email'],
                course_id: section_data['courseId'],
                grader_needed: 1
            )
        end
    end

    # get weekday data for each section
    def weekday_getter(section_data)
        result = ""
        weekday = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
        section_data['meetings'].each do |meeting|
            # loop through every weekday, if weekday is true, add it to the result
            7.times do |i|
                if meeting[weekday[i]] == true
                    result += weekday[i] + ", "
                end
            end
        end
        return result
    end
   
end