# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Role.create!(name: "admin")
Role.create!(name: "user")
User.create!(first_name: "admin",
            last_name: "admin",
            email: "admin@demo.com",
            dob: "2017-05-06",
            role_id: "1",
            phone_number: "9744844654",
            password:              "123456",
            password_confirmation: "123456")
User.create!(first_name: "amal",
            last_name: "raj",
            email: "amal@demo.com",
            dob: "2017-05-06",
            role_id: "2",
            phone_number: "9744844654",
            password:              "123456",
            password_confirmation: "123456")
