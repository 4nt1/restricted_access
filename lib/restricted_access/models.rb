module RestrictedAccess
  module Models
    extend ActiveSupport::Concern

    module ClassMethods

      attr_reader :accesses

      def access_levels(accesses)
        @accesses = accesses.map { |k, v| Access.new(k, v) }

        # define level store field
        if defined?(Mongoid::Document)
          enum :level, accesses.keys
        elsif defined?(ActiveRecord::Base)
          enum level: accesses
        else
          raise 'Your ORM is not recognized.'
        end

      end

      def access(level_name)
        @accesses.find { |a| a.level == level_name }
      end
    end

    def access
      self.class.access(level.to_sym)
    end

    def authorized_accesses
      self.class.accesses.select { |a| a <= access }
    end

  end
end