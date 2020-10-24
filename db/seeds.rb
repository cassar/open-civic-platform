# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'faker'

admin = User.create(
  email: (ENV['SEED_EMAIL'] || 'admin@open-civic.com'),
  password: 'password',
  password_confirmation: 'password'
)

Profile.new name: (ENV['SEED_NAME'] || 'Admin User'), userable: admin

10.times do |number|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  user = User.create(email: "#{first_name}_#{last_name}#{number}@example.com",
    password: Devise.friendly_token[0, 20])
  user.profile.update! name: "#{first_name} #{last_name}"
end

5.times do |number|
  group = Group.create(name: "#{Faker::Book.unique.title} Club")
  Profile.all.take(10).each do |profile|
    group.memberships.create(
      profile: profile,
      status: ['Member', 'Invitee'].sample,
      subscribed: [true, false, nil].sample
    )
  end
end

def create_supports(issues, positions)
  profiles = Profile.all
  100.times do
    adoption = Adoption.find_or_create_by(
      profile: profiles.sample,
      issue: issues.sample
    )
    Support.create(
      adoption: adoption,
      position: positions.sample,
      preference: (adoption.supports.count + 1)
    )
  end
end

def paragraph
  "#{Faker::Lorem.paragraph(sentence_count: 10)}\r\n\r\n#{Faker::Lorem.paragraph(sentence_count: 10)}"
end

issues = 100.times.map do
  Issue.create(
    name: "What is #{Faker::Games::Pokemon.unique.name}'s best move?",
    outline: paragraph
  )
end

positions = 50.times.map do
  Position.create(
    name: Faker::Games::Pokemon.unique.move,
    outline: paragraph
  )
end

create_supports(issues, positions)
