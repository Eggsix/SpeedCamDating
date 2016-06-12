class RegistrationsController < Devise::RegistrationsController
  
  def update_resource(resource, params)
    if resource.encrypted_password.blank? # || params[:password].blank?
      resource.email = params[:email] if params[:email]
      if !params[:password].blank? && params[:password] == params[:password_confirmation]
        logger.info "Updating password"
        resource.password = params[:password]
        resource.save
      end
      if resource.valid?
        resource.update_without_password(params)
      end
    else
      resource.update_with_password(params)
    end
  end
  
  def create
    build_resource(sign_up_params)
 
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up 
        sign_up(resource_name, resource)
        return render :json => {:success => flash[:notice] }
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" 
        expire_session_data_after_sign_in!
        return render :json => {:success => true}
      end
    else
      clean_up_passwords resource
      return render :json => {:errors => resource.errors.full_messages }
    end
  end
 
  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    devise_parameter_sanitizer.sanitize(:sign_up)
    sign_in(resource_name, resource)
  end
  
  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :gender, :age)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
  
end