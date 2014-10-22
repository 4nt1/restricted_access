module RestrictedAccess
  class Access
    include Comparable
    attr_accessor :level, :label, :power

    def <=>(access)
      power <=> access.power
    end

    def initialize(level, label, power)
      @level = level
      @label = label
      @power = power
    end

  end
end