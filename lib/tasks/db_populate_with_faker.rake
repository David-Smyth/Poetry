# Rake task that uses the faker gem to populate
# development and test databases with fake users.

namespace :db do
  desc "Fill database with sample users"
  task populate: :environment do
    password = "YouWillNeverGue$$"
    dom1 = %w(This That Those Them All Other Not)
    dom2 = %w(Fire Room Group Firm Out Green Sue Govment)
    dom3 = %w(com org us gov tv de uk fr co.nz)
    User.create!( 
      name: "Betty Rubble",
      email: "Betty@BBQforAll.fire",
      password: password,
      password_confirmation: password,
      admin: true)
    99.times do |n|
      name = Faker::Name.name
      name_no_blanks = name.gsub(/\s+/, "")
      email = "#{name_no_blanks}@#{dom1.sample}#{dom2.sample}.#{dom3.sample}"
      User.create!( 
        name: name, 
        email: email,
        password: password, 
        password_confirmation: password )
    end
  end
end
