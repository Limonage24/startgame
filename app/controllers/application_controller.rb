class ApplicationController < ActionController::Base
  include SessionHelper

  before_action :require_login

  private

  def require_login
    unless signed_in?
      redirect_to root_url
    end
  end

  def admin_access
    unless @current_user&.role == 'admin'
      redirect_to root_url
    end
  end

  def is_current
    unless @current_user == @user
      redirect_to root_url
    end
  end
end
