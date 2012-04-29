class ApplicationController < ActionController::Base
  before_filter :set_locale

  protect_from_forgery
  
  protected
  def set_locale
    session[:locale] = I18n.locale = params[:locale] || I18n.default_locale
  end  
end
