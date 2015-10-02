require "restricted_access/version"
require 'restricted_access/configuration'
require 'restricted_access/access'
require 'restricted_access/models'
require 'restricted_access/helper'

module RestrictedAccess

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
      require 'restricted_access/controller'
      ActionController::Base.send(:include, RestrictedAccess::Controller)
      ActionView::Base.send(:include, RestrictedAccess::Helper)
    end

    def resources
      @resources ||= configuration.resources
    end

  end
end