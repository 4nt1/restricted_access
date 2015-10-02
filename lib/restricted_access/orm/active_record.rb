require 'active_record'

ActiveRecord::Base.extend RestrictedAccess::Models::ClassMethods
ActiveRecord::Base.include RestrictedAccess::Models
