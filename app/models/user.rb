class User < ApplicationRecord
    has_many :cart_item
    has_many :order
    has_secure_password(:password)
    validates :firstname, presence: true, length: {minimum: 3, maximum: 30}
    validates :email, presence: true, uniqueness: true
    validates :mobile_num, length: {is: 10}, allow_blank: true
    validates_inclusion_of :role, :in => %w(customer billing_clerk owner)

    def check_role(expected_role)
        role.to_s == expected_role.to_s
    end

    def name
        lastname ? "#{firstname} #{lastname}" : firstname
    end

    def self.existing
      all.where(archived_at: nil)
    end

    def self.billing_clerks
        all.existing.where(role: "billing_clerk")
    end

    def self.customers
        all.existing.where(role: "customer")
    end

    def self.owners
      all.existing.where(role: "owner")
    end

    def self.non_customers
      all.existing.where.not(role: "customers")
    end

    def self.neglect(exclusion)
      all.existing.where.not(id: exclusion.id)
    end

    def self.search(query)
      if(query.empty?)
        all
      else
        query = query.downcase
        all.where('LOWER(CONCAT(firstname, lastname)) LIKE (?)', "%#{query}%").or(
          all.where('LOWER(mobile_num) LIKE (?)', "%#{query}%").or(
          all.where('LOWER(email) LIKE (?)', "%#{query}%")))
      end
    end

    def self.walkin_customer
      User.find_by(firstname: "Walk-In")
    end
end
