require "mongoid/enum"
require "restricted_access/version"
require 'restricted_access/configuration'
require 'restricted_access/access'
require 'restricted_access/models'
# require 'restricted_access/controller'
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

    def resources
      @resources ||= configuration.resources
    end

    def controller_scope
      @controller_scope ||= configuration.controller_scope
    end

    def define_dynamic_methods
      ApplicationController.class_eval do
        RestrictedAccess.resources.each do |resource_name|
          klass = resource_name.to_s.classify.constantize
          klass.levels.each do |level|
            puts "#{resource_name} - #{level.level}"
            define_method "prevent_#{level.level}_#{resource_name}_access" do
              restrict_access if send("current_#{resource_name}").access <= klass.send(:access, level.level)
            end
          end

        end

        define_method :restrict_access do
          redirect_to root_path, notice: 'You do not have access to this page' and return
        end

      end

    end
  end
end