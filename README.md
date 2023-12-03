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
The in
   
### Admin view:
The admin view is given the most functionality. When the user logs into the default admin view they can approve and deny requests from the button called manage requests on the navigation bar which leads to a page to manage the requests. The admin can also reload the data from the reset button on the navigation bar and change their information using the button change my info. The admin can add courses, add sections, edit courses, edit sections, delete courses, and delete sections from the buttons on the course catalog. Additionally, admins can manage requests to be able to view the admin view and manage applications from students that apply to be a grader. The default admin user name is admin.1@osu.edu and the password is admin123.

-- Manage requests:
   All admins can view the requests to be an admin or to be an instructor. When an instructor or an admin that is not default signs up a request is automatically sent to the deafult admin. The default admin can click on the manage requests button in the nav-bar and approve or deny users.
   ![Alt text](<Screenshot 2023-12-03 at 6.13.55 PM.png>)
-- Manage applications:
### Optional Extensions:


The default admin user name is admin.1@osu.edu and the password is admin123. When the user logs into the default admin view they can approve and deny requests from the button called manage requests on the navigation bar which leads to a page to manage the requests. The admin can also reload the data from the reset button on the navigation bar and change their information using the button change my info. The admin can add courses, add sections, edit courses, edit sections, delete courses, and delete sections from the buttons on the course catalog. 

All users can search for courses with the search bar, the academic career drop-down, the campus drop-down, and the term drop-down. When a user is in the course catalog without any inputs in the search parameters, the courses are paginated, and when a user searches for a class all the results of the search will be on one page.


## Installation instructions
1. Download VS code
2. Clone the repository for project 2
3. Install Ruby 3.2.0 and Rails 7.0.8 (Instructions are in Setting up a development environment in the modules section in Carmen for class 3901)
4. In the terminal type 'cd lab2'
5. Once that is completed, run in the command line in terminal 'bundle' then 'rails db:migrate' then 'rails db:seed'
6. Finally 'run the rails server' in terminal and click one of the links that are given once the command is run successfully, and it should show the the login page

## Possible installation issues
 1. If there is an issue with the steps on installing ruby or rails, try turning off the computer and turning it on the going through the steps again
 2. If there is some gem that cannot be installed after 'bundle', refer to the Gemfile to make sure correct version of ruby and rails are there
 3. If the apllication is taking a long time to load or the application is frozen then, the rails server needs to be terminated and started again. To do that, first type in "lsof -i :3000" to kill the server then the PID of the server shows up when that command is run. for the next command type in the terminal "kill -9 <pid>". After that a message should show up stating that the server was terminated. Then run "rails server" in the terminal to fix the issue at hand.

![alt text](http://url/to/osu.png)
