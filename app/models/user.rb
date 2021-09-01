class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:twitter]

  validates :name, presence: true, on: :update
  validates :email, presence: true
  # ユーザー作成(新規登録)の時だけパスワード入力必須にする on: :create をセットで記述。
  validates :password, presence: true, on: :create

  attr_accessor :current_password

  # Twitter認証ログイン用
  # ユーザーの情報があれば探し、無ければ作成する
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid: auth.uid,
        provider: auth.provider,
        name: auth.info.name,
        username: auth.info.nickname,
        email: User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        image: auth.info.image
      )
      user.save!
    end
    current_user = user
  end

  # ダミーのメールアドレスを作成
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
