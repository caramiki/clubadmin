# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create users
super_admin = User.where(email: "superadmin@example.com").first_or_create do |u|
  u.assign_attributes(
    first_name: "Super",
    last_name: "Admin",
    email: "superadmin@example.com",
    password: "password",
    password_confirmation: "password",
    super_admin: true
  )
end

admin = User.where(email: "admin@example.com").first_or_create do |u|
  u.assign_attributes(
    first_name: "Admin",
    last_name: "Catclub",
    email: "admin@example.com",
    password: "password",
    password_confirmation: "password"
  )
end

organizer = User.where(email: "organizer@example.com").first_or_create do |u|
  u.assign_attributes(
    first_name: "Organizer",
    last_name: "Catclub",
    email: "organizer@example.com",
    password: "password",
    password_confirmation: "password"
  )
end

# Create club
club = Club.where(name: "Cat Club").first_or_create do |c|
  c.description = "A club for fans of cats"
  c.creator = admin
end

# Create roles
# admin was automatically made the admin by being the creator of Cat Club
Role.create!(club: club, user: organizer, level: :organizer) unless organizer.clubs.include?(club)

# Create members
[
  ["Amy", "Anderson"],
  ["Bailey", "Wilson"],
  ["Cortney", "Baker"],
  ["Devin", "Powers"],
  ["Evelyn", "Fox"],
  ["Frank", "Limyder"],
  ["George", "Harold"],
  ["Harriet", "Jones"],
  ["Irma", "Washington"],
  ["Joey", "Michaels"]
].each do |f, l|
  Member.where(first_name: f, last_name: l).first_or_create do |m|
    m.club = club
  end
end

# Create meetings and attendances
unless club.meetings.any?
  first_meeting = Date.parse("Monday") - 10.weeks
  meeting_names = ["Show & Tell", "Presentation Night", "Workshop", "Social Night"]

  20.times do |i|
    start_time = (first_meeting + i.weeks).to_datetime + 18.hours

    club.meetings.create!(
      title: meeting_names[i % 4],
      start_time: start_time,
      end_time: start_time + 2.hours
    )
  end

  club.meetings.past.each do |m|
    attendees = club.members.order("RANDOM()").limit(rand(4..10)).to_a
    attendees << admin.membership(club) unless attendees.include?(admin.membership(club))
    attendees << organizer.membership(club) unless attendees.include?(organizer.membership(club))

    attendees.each do |a|
      a.attendances.create!(meeting: m)
    end
  end
end
