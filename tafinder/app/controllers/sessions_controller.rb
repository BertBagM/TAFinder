class SessionsController < ApplicationController
  def new
  end

  def create
    permitted = session_params()
    authorized_user = User.authenticate(permitted[:email], permitted[:password])

    if (authorized_user)
      session[:user_id] = authorized_user.id
      redirect_to('/admin/course')
    else
      flash.now[:danger] = 'Invalid email or password'
      render('new')
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to('/')
  end


  private

  def session_params
    params.require(:session).permit(
      :email,
      :password
    )
  end
end
