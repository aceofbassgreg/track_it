class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!, except: [:sign_in, :register]
    
  helper_method :graph
end
