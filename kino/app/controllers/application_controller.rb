class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  after_filter :store_location

  def store_location
    # сохраянем последний URL - нужно, чтобы при логине или регистрации редиректило на предыдущую страницу.
    return unless request.get?
    if request.path != '/users/sign_in' &&
        request.path != '/users/sign_up' &&
        request.path != '/users/password/new' &&
        request.path != '/users/password/edit' &&
        request.path != '/users/confirmation' &&
        request.path != '/users/sign_out' &&
        !request.xhr? # не храним вызовы ajax
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :sex, :permission) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password_confirmation, :password, :sex, :permission) }
  end
end
