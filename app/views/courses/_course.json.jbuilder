json.extract! course, :id, :name, :pin, :professor_id, :created_at, :updated_at, :voting
json.url course_url(course, format: :json)
