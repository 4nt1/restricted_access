module RestrictedAccess
  module Generators
    class InstallGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers
      source_root File.expand_path('../templates', __FILE__)
      argument      :resource_name,     type: :string,  default: 'user'
      class_option  :levels,            type: :array,   default: ['normal', 'super'],   desc: "List of the differents access levels"
      class_option  :controller_scope,  type: :string,                                  desc: "Scope of the concerned controllers"

      desc "Creates a RestrictedAccess initializer."

      def set_variable
        @levels           = options.levels
        @resource_name    = resource_name
        @controller_scope = options.controller_scope
      end

      def copy_initializer
        template "restricted_access.erb", "config/initializers/restricted_access.rb"
      end

    end
  end
end