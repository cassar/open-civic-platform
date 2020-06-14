# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'faker'

admin = User.create(email: ENV['SEED_EMAIL'],
            password: 'password', password_confirmation: 'password')

admin.profile.update! name: ENV['SEED_NAME']

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

20.times do
  Issue.create name: "#{Faker::Quote.famous_last_words}?"
end

20.times do
  Position.create name: Faker::Movie.title, outline: Faker::Movie.quote
end

profiles = Profile.all
issues = Issue.all
positions = Position.all

100.times do
  Support.create(
    profile: profiles.sample,
    issue: issues.sample,
    position: positions.sample
  )
end
