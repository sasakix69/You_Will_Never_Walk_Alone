class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # :account_update を記述して、新規登録のときは必要ないが、あとからプロフィール充実させるときは許可したいカラム名をここに追記
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
