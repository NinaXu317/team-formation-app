class Student < ApplicationRecord
    attr_accessor :activation_token
    has_many :takings
    has_many :courses, through: :takings
    has_many :groups, through: :takings
    has_many :preferences
    accepts_nested_attributes_for :courses, allow_destroy: true
    def full_name
        "#{firstname + " " + lastname}"
    end

    before_save { self.email = email.downcase }
    before_create :create_activation_digest

    validates :firstname,  presence: true, length: { maximum: 50 }
    validates :lastname,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, 
            format: { with: VALID_EMAIL_REGEX }, 
            uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    validates :email, uniqueness: true
    def Student.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def full_name
        firstname.to_s + " " + lastname.to_s
    end

    # Activates an account.
    def activate
        update_attribute(:activated, true)
    end

    # Sends activation email.
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    # Returns a random token.
    def Student.new_token
        SecureRandom.urlsafe_base64
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    private

        # Creates and assigns the activation token and digest.
        def create_activation_digest
            self.activation_token  = Student.new_token
            self.activation_digest = Student.digest(activation_token)
        end
end
