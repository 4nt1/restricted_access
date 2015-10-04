module RestrictedAccess
  module Controller

    RestrictedAccess.resources.each do |resource_name|
      klass = resource_name.to_s.classify.constantize rescue nil
      if klass && klass.accesses.present?
        klass.accesses.each do |access|

          define_method "prevent_#{access.level}_#{resource_name}_access" do
            current_resource = send("current_#{resource_name}")
            if current_resource && current_resource.access <= klass.send(:access, access.level)
              if respond_to?("restrict_#{resource_name}_access", true)
                send("restrict_#{resource_name}_access")
              else
                send("restrict_#{current_resource.level}_#{resource_name}_access"
                  )
              end
            end
          end

          define_method "restrict_#{access.level}_#{resource_name}_access" do
            redirect_to root_path, notice: 'You do not have access to this page' and return
          end
        end
      end

    end

  end
end