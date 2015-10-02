require 'orm_adapter/adapters/mongoid'

Mongoid::Document::ClassMethods.send :include, RestrictedAccess::Models::ClassMethods
Mongoid::Document.send :include, RestrictedAccess::Models
Mongoid::Document.send :include, Mongoid::Enum
