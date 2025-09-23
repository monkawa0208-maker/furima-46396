class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD'] # 環境変数を読み込む記述に変更
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[nickname last_name first_name last_name_kana first_name_kana birthday]
    birthday_multiparams = %i["birthday(1i)" "birthday(2i)" "birthday(3i)"]
    permitted_keys = added_attrs + birthday_multiparams

    devise_parameter_sanitizer.permit(:sign_up, keys: permitted_keys)
  end
end
