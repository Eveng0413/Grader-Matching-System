# Project introduction
For the third project, we created a web application that helps students, instructors and admin browse the course catalog and also helps streamline the process of matching student graders to course sections. Overall, this lab entails creating users for the student, instructor, and admin. Additionally, admins will be able to approve or deny requests to view the admin view from users who sign up as the admin or instructor. The admins can also edit the course catalog, reload the course catalog and browse the course catalog. The users who sign up as students or instructors can browse the course catalog and instructors can request access to view admin view. The web application utilizes SQL lite for the database, Ruby/Rails program to use the enclosed API to process the section and course info from the publicly accessible OSU course catalog.


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
   --Grader Application: The Student can select sections and their preferences for the availability(Mornings/Afternoon/Evening) and then apply for the grader position.  
   --Information Button: The Student can add their availability in this section and also the courses they think they are qualified for being a grader. The availability can be taken into account by the admin when they look through applications.   
  
### Instructor view:
When the instructor first makes an account, the student view will be present until the admin approves the instructor. Once approved, the instructor can recommend students and evaluate the student.
-- Recommend student:
   In the nav bar, the button recommend student, the instructor can include the student's name, email, course to recommend, instructor email, and if they want to recommend the student. Once this is submitted it can be viewed in student details in the admin manage applicants button.
   ![Alt text](<Screenshot 2023-12-03 at 7.32.06 PM.png>)

-- Evaluate Student:
   If a student has already been a grader then the instructor can click the evaluate button in the nav bar and enter the student's email, course name, rating,and description. Once submitted it can viewed as student details in the admin page.
   
### Admin view:
The admin view is given the most functionality. When the user logs into the default admin view they can approve and deny requests from the button called manage requests on the navigation bar which leads to a page to manage the requests. The admin can also reload the data from the reset button on the navigation bar and change their information using the button change my info. The admin can add courses, add sections, edit courses, edit sections, delete courses, and delete sections from the buttons on the course catalog. Additionally, admins can manage requests to be able to view the admin view and manage applications from students who apply to be a grader. The default admin user name is admin.1@osu.edu and the password is admin123.

-- Manage requests:
   All admins can view the requests to be an admin or to be an instructor. When an instructor or an admin that is not default signs up a request is automatically sent to the default admin. The default admin can click on the manage requests button in the nav-bar and approve or deny users. The image shows what should be seen after the user clicks on the manage requests button.
   ![Alt text](<Screenshot 2023-12-03 at 6.13.55 PM.png>)
-- Manage applications:
   All admins can view(shown in image 1) the grader applications that are sent from students. Admins can see the student email, course interested, section interested, time interested, status of the application, and applicate information. The admin can approve or deny a grader application the results will show in the status column(denied, approved, or pending). Once a grader is approved, the course and section applied for will show a grader in the home page. Also, admins can manually edit the amount of graders. In the applicant info column, the admin can click on the view details button for each student and view the student's application and if they have an evaluation (shown in image 2).

-- Reload data:
   Located in the nav-bar the button reload. This button leads to a page into which section offering information is updated each semester. This is supported by pulling in data from external data sources. The user can load OSU CSE courses from the OSU API. The user enters keywords, term values, campus values, and academic career to reload the database. 
   ![Alt text](<Screenshot 2023-12-03 at 7.02.00 PM.png>)

### Optional Extensions:
Applicant Preferences: Students can provide their preferences once they click the grader application button in the student page. The student can choose a course, section, and time that they are interested and once submitted, it will show sections that match that criteria and the student can select a section. Then the admin can see what the student is interested in. 

Evaluation:
This is shown on the instructor page. Instructors can evaluate previous graders and admins can view this in the admin page.





## Installation instructions
1. Download VS code
2. Clone the repository for project 2
3. Install Ruby 3.2.0 and Rails 7.0.8 (Instructions are in Setting up a development environment in the modules section in Carmen for class 3901)
4. In the terminal type 'cd lab2'
5. Once that is completed, run in the command line in terminal 'bundle' then 'rails db: migrate' then 'rails db: seed'
6. Finally 'run the rails server' in the terminal and click one of the links that are given once the command is run successfully, and it should show the the login page

## Possible installation issues
 1. If there is an issue with the steps on installing ruby or rails, try turning off the computer and turning it on then going through the steps again
 2. If there is some gem that cannot be installed after 'bundle', refer to the Gemfile to make sure the correct version of ruby and rails are there
 3. If the application is taking a long time to load or the application is frozen then, the rails server needs to be terminated and started again. To do that, first type in "lsof -i :3000" to kill the server then the PID of the server shows up when that command is run. for the next command type in the terminal "kill -9 <pid>". After that a message should show up stating that the server was terminated. Then run "rails server" in the terminal to fix the issue at hand.

![alt text](http://url/to/osu.png)

