namespace :populate_database do
  desc "Create 'Registered User', 'Store Manager', 'Store Admin' and 'Platform Admin' roles in database."
  task generate_roles: :environment do

    roles = ['Registered User', 'Store Manager', 'Store Admin', 'Platform Admin']
    saved_roles = 0
    total_roles = 0

    roles.each do |role|
      if Role.find_by(name: role)
        puts "#{role} already exists."
      else
        record = Role.new(name: role)
        saved_roles += 1 if record.save
        total_roles += 1
      end
    end

    puts "#{saved_roles} out of #{total_roles} successfully saved."
  end

  task assign_roles_for_existing_users: :environment do
    users      = User.all
    registered = Role.find_by(name: 'Registered User')
    platform   = Role.find_by(name: 'Platform Admin')
    admin = 0
    default = 0

    users.each do |user|
      if user.role == 'default'
        user.roles << registered
        default += 1
        puts "Registered User assigned"
      elsif user.role == 'admin'
        user.roles << platform
        admin += 1
        puts "Platform Admin assigned"
      end
    end

    puts "Of all #{users.count} users, you have assigned #{admin} 'Platform Admin', and #{default} 'Registered Users'"
    puts "#{admin + default}/#{users.count} have been successfully assigned a role."
  end
end