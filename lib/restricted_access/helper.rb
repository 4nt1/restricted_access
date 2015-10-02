module RestrictedAccess
  module Helper
    def available_for(level, resource_name, &block)
      klass   = resource_name.to_s.classify.constantize
      access  = klass.send(level)
      capture(&block) if access && send("current_#{resource_name}") && send("current_#{resource_name}").access >= access
    end
  end
end