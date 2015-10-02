require 'orm_adapter/adapters/active_record'

ActiveRecord::Base.extend RestrictedAccess::Models::ClassMethods
ActiveRecord::Base.include RestrictedAccess::Models
