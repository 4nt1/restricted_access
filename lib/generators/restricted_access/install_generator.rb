module RestrictedAccess
  module Generators
    class InstallGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers
      source_root File.expand_path('../templates', __FILE__)
      argument      :levels,            type: :array,   default: ['normal', 'super'],   desc: "List of the differents access levels", banner: 'level level'
      class_option  :resource_name,     type: :string,  default: 'user'
      class_option  :controller_scope,  type: :string,                                  desc: "Scope of the concerned controllers"

      desc "Creates a RestrictedAccess initializer."

      def set_variable
        @levels           = levels
        @resource_name    = options.resource_name
        @controller_scope = options.controller_scope
      end

      def copy_initializer
        template "restricted_access.erb", "config/initializers/restricted_access.rb"
      end

    end
  end
end