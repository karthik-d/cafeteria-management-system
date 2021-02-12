class MenuPolicy
    attr_reader :role

    def initialize(role)
        @role = role
    end

    def index?
        ['owner', 'billing_clerk'].include? @role
    end

    def new?
        ['owner'].include? @role
    end

    def create?
        ['owner'].include? @role
    end

    def update?
        ['owner'].include? @role
    end
end
