module RestrictedAccess
  module Helper
    def available_for(level, &block)
      access = RestrictedAccess::Access.send(level)
      capture(&block) if access && send("current_#{RestrictedAccess.resource}") && send("current_#{RestrictedAccess.resource}").access >= access
    end
  end
end