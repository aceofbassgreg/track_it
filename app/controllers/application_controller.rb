class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!, except: [:sign_in, :register]

  helper_method :graph
  
  rescue_from CanCan::AccessDenied, with: :deny_access
  
  def deny_access
    flash[:error] = I18n.t "access.denied"
    redirect_to root_path
  end
end
