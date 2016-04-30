# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'random_data'
require 'rubygems'
require 'faker'

User.destroy_all

for i in 1..5
  user = User.create!(
  name: "user#{i}",
  email: "user#{i}@example.com",
  password: "hello123", 
  password_confirmation: "hello123"
  )
  user.skip_confirmation!
  user.save
end

users = User.all

#Create Registered Applications
40.times do
    RegisteredApplication.create!(
        name:  RandomData.random_sentence,
        url:   RandomData.random_sentence,
        user: users.sample
)
end

registered_applications = RegisteredApplication.all

100.times do
  user = Event.create!(
    name: Faker::Name.name,
    registered_application: registered_applications.sample
)
end

events = Event.all

puts "Seed finished"
puts "#{RegisteredApplication.count} Applications created"
puts "#{Event.count} Events created"
puts "#{User.count} Users created"
