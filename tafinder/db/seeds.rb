# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# TODO(scott): add proper admin account before deploying
users = User.create([
  {
    email: "admin@admin.com",
    password: "password"
  }
])

if (Rails.env == "development")
  terms = Term.create([
    {
      year: "2016",
      semester: "F/W",
      open: true
    }
  ])
end