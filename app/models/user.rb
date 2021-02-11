class User < ApplicationRecord
    has_secure_password(:password)
    validates :firstname, presence: true, length: {minimum: 4, maximum: 30}
    validates :email, presence: true, uniqueness: true
    validates :mobile_num, length: {is: 10}, allow_blank: true

    def check_role(role)
        role == role
    end
end
