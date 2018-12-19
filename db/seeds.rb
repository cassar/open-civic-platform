# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'faker'

admin = User.create(email: ENV['SEED_EMAIL'],
            password: 'password', password_confirmation: 'password')

Profile.create(userable: admin, name: ENV['SEED_NAME'])

first_names = ['Tim', 'Kate', 'Watson', 'Zhang', 'Maria', 'Omar', 'Ezara']
last_names = ['Kumar', 'Huang', 'Zammit', 'Tyrel', 'Conner', 'Drizen']

10.times do |number|
  first_name = first_names.sample
  last_name = last_names.sample
  user = User.create(email: "#{first_name}_#{last_name}#{number}@example.com",
    password: Devise.friendly_token[0, 20])
  Profile.create(userable: user, name: "#{first_name} #{last_name}")
end

adjectives = ['Tame', 'Big', 'Loud', 'Poor', 'Vibrant', 'Stoic']
nouns = ['Golfers', 'Readers', 'Livers', 'People', 'Nobodies']

5.times do |number|
  adjective = adjectives.sample
  noun = nouns.sample
  group = Group.create(name: "#{adjective} #{noun} #{number}")
  Profile.all.take(10).each do |profile|
    group.memberships.create(profile: profile, status: ['Member', 'Invitee'].sample)
  end

  3.times do |issue_number|
    issue = group.issues.create(name: "Issue #{issue_number}")

    position = issue.positions.create(name: 'Position 1', outline: Faker::Lorem.paragraph)
    position.supports.create(membership: group.confirmed_memberships.first)

    position = issue.positions.create(name: 'Position 2', outline: Faker::Lorem.paragraph)
    position.supports.create(membership: group.confirmed_memberships.last)
  end
end
