class RegistrationsController < Devise::RegistrationsController
  
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
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :gender, :age)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end