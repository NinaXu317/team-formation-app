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

(1..100).each do
    first = Faker::Name.first_name
    last = Faker::Name.last_name
    s = Student.create(firstname: first,
                        lastname: last,
                        email: last + "@brandeis.edu",
                        password: "password")
end


Student.delete_all(firstname: "admin", lastname: "admin")
admin_student = Student.create(firstname: "admin",
    lastname: "admin",
    email: "admin@admin.com",
    password: "password")

(1..50).each do
    p = Professor.create(firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "password")
end

Professor.delete_all(firstname: "admin", lastname: "admin")
admin_professor = Professor.create(firstname: "admin",
    lastname: "admin",
    email: "admin@admin.com",
    password: "password")

10.times do
    c = Course.create(name: Faker::Educator.course_name,
    pin: Faker::Number.number(digits: 4),
    professor_id: admin_professor.id)
end

30.times do
    c = Course.create(name: Faker::Educator.course_name,
    pin: Faker::Number.number(digits: 4),
    professor_id: Professor.all.sample.id)
end

5.times do
    g = Group.create(course_id: admin_professor.courses.all.sample.id,
    project_name: Faker::Team.name)
end

60.times do
    g = Group.create(course_id: Course.all.sample.id,
    project_name: Faker::Team.name)
end

100.times do 
    g = Group.create(course_id: Course.where(professor_id: admin_professor.id).sample,
                    project_name: Faker::Team.name)
end

30.times do
    n = admin_professor.courses.all.sample.id
    s = Student.all.sample.id
    #t = Taking.create(student_id: s, course_id: n, group_id: Group.where(course_id: n).sample.id)
    t = Taking.create(student_id: s, course_id: n)
end

200.times do
  n = Course.all.sample.id
  s = Student.all.sample.id
  t = Taking.create(student_id: s, course_id: n)
end

admin_professor.courses.each do |course|
    groups = course.groups
    if groups.size > 0
        course.students.each do |student|
            p = Preference.create(course_id: course.id, 
                                    student_id: student.id, 
                                    first: groups.sample.id, 
                                    second: groups.sample.id,
                                    third: groups.sample.id)
        end
    end
end
