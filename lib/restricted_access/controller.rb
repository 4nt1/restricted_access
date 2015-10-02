module RestrictedAccess
  module Controller

    RestrictedAccess.resources.each do |resource_name|
      klass = resource_name.to_s.classify.constantize
      klass.accesses.each do |access|
        puts "#{resource_name} - #{access.level}"
        define_method "prevent_#{access.level}_#{resource_name}_access" do
          restrict_access if send("current_#{resource_name}").access <= klass.send(:access, access.level)
        end
      end

    end

    define_method :restrict_access do
      redirect_to root_path, notice: 'You do not have access to this page' and return
    end
  end
end