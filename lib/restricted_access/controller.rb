module RestrictedAccess
  module Controller

    def restrict_access
      flash[:danger] = 'Vous n\'êtes pas autorisé à consulter cette page'
      redirect_to backoffice_root_path and return
    end
  end

end