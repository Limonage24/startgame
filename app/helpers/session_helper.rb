module SessionHelper
  def sign_in(user)
    cookies.signed[:user_id] = { value: user.id, http_only: true, expires: 2.hours }
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    cookies.signed[:user_id] = nil
    self.current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
  end
end
