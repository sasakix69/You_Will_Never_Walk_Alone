class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!, except: %i[index]

  protected

  # :account_update を記述して、新規登録のときは必要ないが、あとからプロフィール充実させるときは許可したいカラム名をここに追記
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name image avatar favorite_player kop_history])
  end
end
