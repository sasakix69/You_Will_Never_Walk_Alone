class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:twitter]

  # Twitter認証ログイン用
  # ユーザーの情報があれば探し、無ければ作成する
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
      
    unless user
      user = User.create(
              uid:      auth.uid,
              provider: auth.provider,
              name: auth.info.name,
              username: auth.info.username,
              email:    User.dummy_email(auth),
              password: Devise.friendly_token[0, 20]
            )
            user.save!
    end
      
    current_user = user
  end
      
  private

  # ダミーのメールアドレスを作成
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
