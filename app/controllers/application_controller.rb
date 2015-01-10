class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "ipadmini", password: "miniipad"
  helper :all # include all helpers, all the time
  helper_method :get_type_id, :get_channel_id

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_type_id
    session[:type_id]
  end

  def get_channel_id
    session[:channel_id]
  end

end
