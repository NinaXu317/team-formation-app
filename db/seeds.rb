# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Student.delete_all
Student.reset_pk_sequence
Professor.delete_all
Professor.reset_pk_sequence
Group.delete_all
Group.reset_pk_sequence
Course.delete_all
Course.reset_pk_sequence
Taking.delete_all
Taking.reset_pk_sequence

(1..100).each do
    s = Student.create(firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    email: Faker::Internet.email)
end
(1..50).each do
    p = Professor.create(firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    email: Faker::Internet.email)
end

30.times do
    c = Course.create(name: Faker::Educator.course_name,
    pin: Faker::Number.number(digits: 4),
    professor_id: Professor.all.sample.id)
end

60.times do
    g = Group.create(course_id: Course.all.sample.id,
    project_name: Faker::Team.name)
end

200.times do
  n = Course.all.sample.id
  s = Student.all.sample.id
  #t = Taking.create(student_id: s, course_id: n, group_id: Group.where(course_id: n).sample.id)
  t = Taking.create(student_id: s, course_id: n)
end
