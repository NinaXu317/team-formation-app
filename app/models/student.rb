class Student < ApplicationRecord
    has_many :takings
    has_many :courses, through: :takings
    has_many :groups, through: :takings
    accepts_nested_attributes_for :courses, allow_destroy: true
    def full_name
        "#{firstname + " " + lastname}"
    end

    before_save { self.email = email.downcase }
    validates :firstname,  presence: true, length: { maximum: 50 }
    validates :lastname,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, 
            format: { with: VALID_EMAIL_REGEX }, 
            uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    def Student.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
end
