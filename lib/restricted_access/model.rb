module RestrictedAccess
  module Model
    extend ActiveSupport::Concern

    included do |base|
      enum :level,                    RestrictedAccess.accesses.map(&:level)
    end

    def access
      RestrictedAccess.accesses.find {|a| a.level == level}
    end

    def authorized_accesses
      RestrictedAccess.accesses.select {|a| a <= access}
    end

  end
end