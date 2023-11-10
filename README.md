# Project introduction
For the second project, we created a web application that helps students, instructors and admin browse the course catalog. However, lab2 is apart of the third lab which is to streamline the process of matching student graders to course sections. Overall, this lab entails creating users for the student, instructor and admin. Additionally, admins will be able to approve or deny requests to view the admin view from users who sign up as the admin or instructor. The admins can also edit the course catalog, reload the course catalog and browse the course catalog. The users who sign up as students or instructors can browse the course catalog and instructors can request access to view admin view. The web application utilizes sql lite for the database, Ruby/Rails program to use the enclosed API to process the section and course info from the publicly accessible OSU course catalog.


## Navigating the Web Application
Once the rails server is running, the user is at the login page, which is our root page. The user can sign up to create an account, by clicking the signup button on the login page. Once the account is created the user can go back to the login in page and sign in. If the user has selected to sign up as an admin, student, or instructor the user will see the course catalog page, unless the user uses the default admin user name and password upon logging in. The default admin user name is admin.1@osu.edu and the password is admin123. When the user logs into the default admin view they can approve and deny requests from the button called manage requests on the navigation bar which leads to a page to manage the requests. The admin can also reload the data from the reset button on the navigation bar and change their information using the button change my info. The admin can add courses, add sections, edit courses, edit sections, delete courses, and delete sections from the buttons on the course catalog. 

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

