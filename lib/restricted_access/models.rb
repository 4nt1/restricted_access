module RestrictedAccess
  module Models
    extend ActiveSupport::Concern

    module ClassMethods

      attr_reader :levels

      def access_levels(levels)
        @levels = levels.map { |k, v| Access.new(k, v) }
        if defined?(Mongoid::Document)
          enum :level, levels.keys
        elsif defined?(ActiveRecord::Base)
          enum :level, levels
        else
          raise 'Your ORM is not recognized.'
        end
      end

      def access(level_name)
        @levels.find { |a| a.level == level_name }
      end
    end

    def access
      self.class.levels.find { |a| a.level == level }
    end

    def authorized_accesses
      self.class.levels.select { |a| a <= access }
    end

  end
end