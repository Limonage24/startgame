class SessionController < ApplicationController
  skip_before_action :require_login, only: %i[login create]

  def login; end

  def create
    user = User.find_by(username: params[:login])

    if user&.authenticate(params[:password])
      sign_in user
      p 'Access approved'
      redirect_to root_url
    else
      p 'Access denied'
      redirect_to session_login_path, alert: 'Incorrect login or password, try again'
    end
  end

  def logout
    sign_out
    redirect_to root_url
  end
end
