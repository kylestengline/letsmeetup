# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

NUM_USERS = 15
NUM_EVENTS = 15
TIMESLOTS_PER_EVENT = 10
USERS_PER_EVENT = 5

NUM_USERS.times do
  User.create!({
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email
  })
end

NUM_EVENTS.times do
  location = Location.create!({
    name: Faker::Company.unique.name,
    address: Faker::Address.unique.street_address
  })

  event = Event.create!({
    name: Faker::GameOfThrones.unique.dragon,
    duration_minutes: rand(300),
    location_id: location.id
  })

  indices = []

  (6 * USERS_PER_EVENT).times do
    indices << rand(NUM_USERS - 1)
  end

  all_users = User.all
  event_users = indices.uniq[0...USERS_PER_EVENT].map { |index| all_users[index] }

  event_users.each do |user|
    EventsUser.create!({
      event_id: event.id,
      user_id: user.id
    })
  end

  TIMESLOTS_PER_EVENT.times do
    timeslot = Timeslot.create!({
      event_id: event.id,
      start_time: Faker::Time.forward(30)
    })

    event_users.each do |user|
      Preference.create!({
        timeslot_id: timeslot.id,
        user_id: user.id,
        preference_type: rand(4)
      })
    end
  end
end
