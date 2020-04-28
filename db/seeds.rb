# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Student.reset_pk_sequence
Professor.reset_pk_sequence
Group.reset_pk_sequence
Course.reset_pk_sequence
Taking.reset_pk_sequence

#Add 100 students into the database
#Email : lastname@brandeis.edu
#Password for everyone: password
(1..100).each do
    first = Faker::Name.first_name
    last = Faker::Name.last_name
    s = Student.create(firstname: first,
                        lastname: last,
                        email: last + "@brandeis.edu",
                        password: "password")
end

#Create an admin student for development use
admin_student = Student.create(firstname: "admin",
    lastname: "admin",
    email: "admin@admin.com",
    password: "password")

#Add 50 professors into the database
#Password for everyone: password
(1..50).each do
    p = Professor.create(firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "password")
end

#Create an admin professor for development use
admin_professor = Professor.create(firstname: "admin",
    lastname: "admin",
    email: "admin@admin.com",
    password: "password")

#Create 10 courses taught by the admin for demo use
10.times do
    c = Course.create(name: Faker::Educator.course_name,
    pin: Faker::Number.number(digits: 4),
    professor_id: admin_professor.id)
end

#Create a consistent course taught by the admin professor for demo use
consistent_course = Course.create(name: Faker::Educator.course_name,
    pin: 1111, professor_id: admin_professor.id)

#Add 30 courses into the database
30.times do
    c = Course.create(name: Faker::Educator.course_name,
    pin: Faker::Number.number(digits: 4),
    professor_id: Professor.all.sample.id)
end

#Add 60 groups into the database
60.times do
    g = Group.create(course_id: Course.all.sample.id,
    project_name: Faker::Team.name, description: Faker::Game.genre)
end

#Add 30 groups into the admin professor's classes for demo uses
30.times do 
    g = Group.create(course_id: Course.where(professor_id: admin_professor.id).sample.id,
                    project_name: Faker::Team.name, description: Faker::Game.genre)
end

#Add 30 students into the admin professor's courses for demo uses
100.times do
    n = admin_professor.courses.all.sample.id
    s = Student.all.sample.id
    t = Taking.create(student_id: s, course_id: n)
end

#Enroll random students in a random class 200 times
20.times do
  n = Course.all.sample.id
  s = Student.all.sample.id
  t = Taking.create(student_id: s, course_id: n)
end

#Add a preference for each student in all of the admin professor's
#courses for demo purposes
admin_professor.courses.each do |course|
    groups = course.groups
    if groups.size > 0
        students = course.students
        students.each do |student|
            p = Preference.create(course_id: course.id, 
                                    student_id: student.id, 
                                    first: groups.sample.id, 
                                    second: groups.sample.id,
                                    third: groups.sample.id,
                                    codingProficiency: 5,
                                    dreampartner: students.sample.id,
                                    schedule: '[{"weekday":"Sunday","start":"08:00:00",
                                    "end":"10:00:00"},{"weekday":"Monday","start":"
                                    10:00:00","end":"12:00:00"},{"weekday":"Wednesday",
                                    "start":"12:00:00","end":"13:00:00"},{"weekday":
                                    "Thursday","start":"09:00:00","end":"10:00:00"},
                                    {"weekday":"Friday","start":"10:00:00","end":"11:00:00"}]')
        end
    end
end
