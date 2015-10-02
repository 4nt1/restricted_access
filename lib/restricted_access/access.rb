module RestrictedAccess
  class Access
    include Comparable
    attr_accessor :level, :power

    def <=>(access)
      power <=> access.power
    end

    def initialize(level, power)
      @level = level
      @power = power
    end

  end
end