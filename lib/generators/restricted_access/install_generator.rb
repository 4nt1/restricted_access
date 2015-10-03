require 'rails/generators/base'
require 'securerandom'
module RestrictedAccess
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc "Creates a RestrictedAccess initializer."
      class_option :orm

      class_option  :resources,            type: :array,   desc: "List of the differents resources", aliases: '-r'

      def copy_initializer
        template "restricted_access.erb", "config/initializers/restricted_access.rb"
      end

    end
  end
end