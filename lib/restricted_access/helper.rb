module RestrictedAccess
  module Helper
    def available_for(level, &block)
      access = RestrictedAccess::Access.send(level)
      capture(&block) if access && current_admin && send("current_#{RestrictedAccess.resource}").access >= access
    end
  end
end