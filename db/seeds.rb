# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require_relative "./seeds/organization"
require_relative "./seeds/admin"
require_relative "./seeds/volunteers"
require_relative "./seeds/students"
require_relative "./seeds/survey"
require_relative "./seeds/survey_responses"
require_relative "./seeds/support_tickets"
