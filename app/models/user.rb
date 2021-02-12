class User < ApplicationRecord
    has_many :cart_item
    has_many :order
    has_secure_password(:password)
    validates :firstname, presence: true, length: {minimum: 3, maximum: 30}
    validates :email, presence: true, uniqueness: true
    validates :mobile_num, length: {is: 10}, allow_blank: true
    validates_inclusion_of :role, :in => %w(customer billing_clerk owner)

    def check_role(role)
        role == role
    end

    def name
        lastname ? "#{firstname} #{lastname}" : firstname
    end

    def self.billing_clerks
        all.where(role: "billing_clerk")
    end

    def self.customers
        all.where(role: "customer")
    end
end
