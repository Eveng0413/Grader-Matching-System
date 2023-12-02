
## a class used to load default admin account into database
class DataLoader
    
    # hardcoded default admin account
    def add_default_admin
        admin_email = "admin.1@osu.edu"
        admin_password = "admin123"
        user1 = User.create!(
            email: admin_email,
            password: admin_password
        )   
                
        Person.create!(
            email: admin_email,
            first_name: "Default",
            last_name: "Admin",
            role: "admin",
            user_id: user1.id
        )
        puts "Default admin added!"
        puts "Email: " + admin_email
        puts "Password: " + admin_password
    end

    def self.load_data
        # Load default admin account into database
        data_loader = DataLoader.new
        data_loader.add_default_admin
    end
   
end

DataLoader.load_data

