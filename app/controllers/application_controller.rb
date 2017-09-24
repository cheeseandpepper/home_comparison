class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_user

  USER_AGENT = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"

  private

  def set_user
    @user = current_user
  end
end
