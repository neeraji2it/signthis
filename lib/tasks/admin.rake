namespace :admin do
  desc 'Create admin from prompt'
  task create: :environment do
    user = User.create!({
      email: prompt_for(:email),
      password: prompt_for(:password)
    })

    puts "Successfully created #{user.email} and added :admin role"
  end

  desc 'Create admins'
  task create_initial: :environment do
    %w[jeff@wevorce.com michelle@wevorce.com lauriek@wevorce.com cynthiaf@wevorce.com sallyc@wevorce.com brianc@wevorce.com caseyh@wevorce.com].each do |email|
      User.where(email: email).first_or_create.update_attributes!(password: 'newfamily')
    end
  end
end
