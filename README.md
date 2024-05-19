# Project introduction
We created a web application that helps students, instructors and admin browse the course catalog and also helps streamline the process of matching student graders to course sections. Overall, this lab entails creating users for the student, instructor, and admin. Additionally, admins will be able to approve or deny requests to view the admin view from users who sign up as the admin or instructor. The admins can also edit the course catalog, reload the course catalog and browse the course catalog. The users who sign up as students or instructors can browse the course catalog and instructors can request access to view admin view. The web application utilizes SQL lite for the database, Ruby/Rails program to use the enclosed API to process the section and course info from the publicly accessible OSU course catalog.


## Navigating the Web Application
Once the rails server is running, the user is at the login page, which is our root page. The user can sign up to create an account, by clicking the signup button on the login page. Once the account is created the user can go back to the login in page and sign in. After you have applied for instructor/admin access at signup, you would by default be logged in as a student at the time and will enjoy the privilege of admin/instructor access after the access is approved by one of the admins.  
##  Login Page
<img width="1440" alt="Screenshot 2023-12-03 at 18 19 58" src="https://github.com/cse-3901-sharkey/2023-Au-Team-1-Lab-3/assets/96990768/5d4e9310-741b-4e93-8e32-96eac7862b85">

##  Signup Page
<img width="1440" alt="Screenshot 2023-12-03 at 18 20 05" src="https://github.com/cse-3901-sharkey/2023-Au-Team-1-Lab-3/assets/96990768/5f7efc36-0574-4c73-b29e-98a03572ae4f">

##  Student View
<img width="1440" alt="Screenshot 2023-12-03 at 18 18 41" src="https://github.com/cse-3901-sharkey/2023-Au-Team-1-Lab-3/assets/96990768/0a4cfec1-6821-4725-8204-09606baf7348">

--Student view: After you are logged in as a student you can search through the course catalog and search by "Course Number" and get all the available Information that you need for that course and available sections.         
   --Change Account Info button: Students can change their name, last name, and password and apply for instructor or admin access by clicking on this button.   
   --Logout Button: By clicking this button the student will be logged out and will land on the login page.  
   --Grader Application: The Student can select  their preferences for the availability(Mornings/Afternoon/Evening) and then apply for the grader position. After click submit, the application has been created and the student will be redirect to the page to select the sections they want to apply for(all the sections from the selected course will be shown and the student could take the responsibility to choose the campus and semester they are looking for).
   And the student can review their old application after click grader application and they can modify their existed application by clicking "edit".
   <img width="1440" alt="Screenshot 2023-12-03 at 11 07 28 PM" src="https://github.com/cse-3901-sharkey/2023-Au-Team-1-Lab-3/assets/89815958/62e62229-8ab9-40a3-8265-f062e1bb04d4">

   
   --Information Button: The Student can add their availability in this section and also the courses they think they are qualified for being a grader. The availability can be taken into account by the admin when they look through applications. 
   <img width="1369" alt="Screenshot 2023-12-03 at 8 19 27 PM" src="https://github.com/cse-3901-sharkey/2023-Au-Team-1-Lab-3/assets/89815958/cf881e06-d91e-49cf-a8ac-6e96fbf50208">

  
### Instructor view:
When the instructor first makes an account, the student view will be present until the admin approves the instructor. Once approved, the instructor can recommend students and evaluate the student.
-- Recommend student:
   In the nav bar, the button recommend student, the instructor can include the student's name, email, course to recommend, instructor email, and if they want to recommend the student. 
   There are two types of recommendation: one is a request for the upcoming semester, and annother is recommendation for future semester. If it is the request for upcoming semester, after instructor clicked submit, the request will be stored and the instructor will be redirect to the page to select the section(all the sections for the selected course will be shown so the user should mind about the campus and semester associated with the section). If it is recommended for future semesters, the instructor will only need to put the recommended course. Once this is submitted the request for the upcoming semester can be viewed in the admin manage applicants button and the recommendation for future semesters can be viewed in student details.
   If the student recommended is not in the system yet, an account will be generated for them with their email address and 123456 as default password.
   
   <img width="648" alt="Screenshot 2023-12-03 at 7 32 06 PM" src="https://github.com/cse-3901-sharkey/2023-Au-Team-1-Lab-3/assets/89815958/beada96d-b015-4dd4-89e3-98cd19042d52">


-- Evaluate Student:
   If a student has already been a grader then the instructor can click the evaluate button in the nav bar and enter the student's email, course name, rating (from 1 to 5),and description. Once submitted it can viewed as student details in the admin page.
   <img width="739" alt="Screenshot 2023-12-03 at 8 53 05 PM" src="https://github.com/cse-3901-sharkey/2023-Au-Team-1-Lab-3/assets/89815958/7bffb4e7-b0e8-4dc5-a06b-c5c189ad6b89">

   
### Admin view:
The admin view is given the most functionality. When the user logs into the default admin view they can approve and deny requests from the button called manage requests on the navigation bar which leads to a page to manage the requests. The admin can also reload the data from the reset button on the navigation bar and change their information using the button change my info. The admin can add courses, add sections, edit courses, edit sections, delete courses, and delete sections from the buttons on the course catalog. Additionally, admins can manage requests to be able to view the admin view and manage applications from students who apply to be a grader. The default admin user name is admin.1@osu.edu and the password is admin123.

-- Manage requests:
   All admins can view the requests to be an admin or to be an instructor. When an instructor or an admin that is not default signs up a request is automatically sent to the default admin. The default admin can click on the manage requests button in the nav-bar and approve or deny users. The image shows what should be seen after the user clicks on the manage requests button.
   ![Alt text](<Screenshot 2023-12-03 at 6.13.55 PM.png>)
-- Manage applications:
   All admins can view(shown in image 1) the grader applications that are sent from students. Admins can see the student email, course interested, section interested, time interested, status of the application, and application information. The admin can approve or deny a grader application the results will show in the status column(denied, approved, or pending). Once a grader is approved, the course and section applied for will show a grader in the home page. Also, admins can manually edit the amount of graders. In the applicant info column, the admin can click on the view details button for each student and view the student's application and if they have an evaluation (shown in image 2). In image3 ,it also shows admin can approve/deny teacher's request, all the logic is the same with grader application
   <img width="958" alt="Screenshot 2023-12-03 at 8 57 15 PM" src="https://github.com/cse-3901-sharkey/2023-Au-Team-1-Lab-3/assets/89815958/5e9c4b41-770a-4904-ab58-60423d723c86">

   <img width="661" alt="Screenshot 2023-12-03 at 8 26 16 PM" src="https://github.com/cse-3901-sharkey/2023-Au-Team-1-Lab-3/assets/89815958/f73b77d6-c147-4ebf-89db-830d9c03744d">

   <img width="661" alt="Screenshot 2023-12-03 at 8 26 16 PM" src="https://github.com/cse-3901-sharkey/2023-Au-Team-1-Lab-3/assets/123781818/dbc89bd3-d409-4e36-9dff-f66a334b65c2">

   For requests and applications, once the admin clicks the approve, the grader will be assigned to the section either applied by themselves or recommended by the instructor automatically. By default, when admin is making a decision, there will be a section number and course number shown. If there is a course number without section number, it means there is something error when admin/students select the sections. In that case, the admin have to view the student's information and click edit to assign the proper section manually.

-- Reload data:
   Located in the nav-bar the button reload. This button leads to a page into which section offering information is updated each semester. This is supported by pulling in data from external data sources. The user can load OSU CSE courses from the OSU API. The user enters keywords, term values, campus values, and academic career to reload the database. When loading the data section, an account automatically will be created for the admin. The admin can decide which parameters they want to load.
   The instructor from the sections has been loaded by admin will have an account generated for them with their email address and 123456 as default password.
   
   <img width="674" alt="Screenshot 2023-12-03 at 7 02 00 PM" src="https://github.com/cse-3901-sharkey/2023-Au-Team-1-Lab-3/assets/89815958/93fb174d-4ee8-4964-970e-b6422d2551d4">


### Optional Extensions:
Applicant Preferences: Students can provide their preferences once they click the grader application button in the student page. The student can choose a course, section, and time that they are interested and once submitted, it will show sections that match that criteria and the student can select a section. Then the admin can see what the student is interested in. 
<img width="1440" alt="Screenshot 2023-12-03 at 9 01 21 PM" src="https://github.com/cse-3901-sharkey/2023-Au-Team-1-Lab-3/assets/89815958/cd4b3f01-5339-4d1d-88dc-672b2b441299">


Evaluation:
This is shown on the instructor page. Instructors can evaluate previous graders and admins can view this in the admin page.





## Installation instructions
1. Download VS code
2. Clone the repository for project 3
3. Install Ruby 3.2.0 and Rails 7.0.8 (Instructions are in Setting up a development environment in the modules section in Carmen for class 3901)
4. In the terminal type 'cd lab3'
5. Once that is completed, run in the command line in terminal 'bundle' then 'rails db: migrate' then 'rails db: seed'
6. Finally 'run the rails server' in the terminal and click one of the links that are given once the command is run successfully, and it should show the the login page

## Possible installation issues
 1. If there is an issue with the steps on installing ruby or rails, try turning off the computer and turning it on then going through the steps again from the setting up development guide on Carmen Canavas. Make sure you are installing the correct tools based on the operating system like Mac or Windows. Utilize StackOverFlow help solve specific issues.
 2. If there is some gem that cannot be installed after 'bundle', refer to the Gemfile to make sure the correct version of ruby(3.2.0) and rails(7.0.8) are there. Additionally, restart the terminal because sometimes the changes didn't apply properly.
 3. If the application is taking a long time to load or the application is frozen then, the rails server needs to be terminated and started again. To do that, first type in "lsof -i :3000" to kill the server then the PID of the server shows up when that command is run. for the next command type in the terminal "kill -9 pid". After that a message should show up stating that the server was terminated. Then run "rails server" in the terminal to fix the issue at hand.
 4. If logged in as student/instructor but not seeing any data of courses displayed, please make sure admin had already loaded course data into the databases(follow Reload data mentioned above).
 5. If admin reload data but not seeing any data of courses displayed, please make sure the correct params(listed in the reload data page) are used to send the form. If the params sent without any data matching from API, the database will still be empty.
 6. If you meet any migration error, make sure you use "rails db:drop" first, then use "rails db:reset" to recreate database
 7. If you try to sign up but is noticed as the account already existed, try to log in with email address and 123456 as default password, since the student recommended when not in the system, and instructor from sections loaded by the admin will have an account generated for them by default.



