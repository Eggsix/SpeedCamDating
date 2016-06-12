class SessionsController < Devise::SessionsController

def new
  super
end

def create
  resource = User.find_for_database_authentication(email: params[:user][:email])
  return invalid_login_attempt unless resource

  if resource.valid_password?(params[:user][:password])
    sign_in :user, resource
    return render :json => {:success => "You have successfully signed in!"}
  end
  invalid_login_attempt
end

protected 

def invalid_login_attempt
  set_flash_message(:alert, :invalid)
  return render :json => {:errors =>  ["Email or password is incorrect"] }
end

end
