require "mongoid/enum"
require "restricted_access/version"
require 'restricted_access/configuration'
require 'restricted_access/access'
require 'restricted_access/model'
require 'restricted_access/controller'
require 'restricted_access/helper'

module RestrictedAccess

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
      define_dynamic_methods
    end

    def accesses
      @accesses ||= configuration.accesses.map do |a|
        Access.new(a[:level], a[:label], a[:power])
      end
    end

    def resource
      @resource ||= configuration.resource
    end

    def controller_scope
      @controller_scope ||= configuration.controller_scope
    end

    def define_dynamic_methods
      # on Access class
      accesses.map(&:level).each do |level|
        Access.define_singleton_method level do
          RestrictedAccess.accesses.find {|a| a.level == level}
        end

        RestrictedAccess::Controller.class_eval do
          define_method "prevent_#{level}_access" do
            restrict_access if send("current_#{RestrictedAccess.resource}").access <= RestrictedAccess::Access.send(level)
          end

          define_method :restrict_access do
            _scope = RestrictedAccess.controller_scope.present? ? "#{RestrictedAccess.controller_scope}_" : nil
            redirect_to send("#{_scope}root_path"), notice: 'You do not have access to this page' and return
          end
        end
      end
    end
  end
end