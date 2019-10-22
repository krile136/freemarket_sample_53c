class User < ApplicationRecord
  has_many :creditcards
  accepts_nested_attributes_for :creditcards

  has_one :delivery_address
  has_many :items
  accepts_nested_attributes_for :delivery_address

  has_many :sns_credentials, dependent: :destroy
  accepts_nested_attributes_for :sns_credentials


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]


  validates :nickname, presence: true
  # # 名前には、全角ひらがな、漢字のバリデーションをかける
  validates :last_name, presence: true, format: {with: /\A[一-龥ぁ-ん]+\z/}
  validates :first_name, presence: true, format: {with: /\A[一-龥ぁ-ん]+\z/}
  # 名前（カナ）には、全角カタカナのバリデーションをかける
  validates :last_name_kana, presence: true, format: {with: /\A[\u30a0-\u30ff]+\z/}
  validates :first_name_kana, presence: true, format: {with: /\A[\u30a0-\u30ff]+\z/}
  # 誕生年には4桁以上の半角数値のバリデーションをかける(--は0扱いになるっぽい)
  validates :birth_year, presence: true, format: {with: /\A[0-9]{4,}\z/}
  # 誕生月日には1~99のバリデーションをかける
  validates :birth_month, presence: true, format: {with: /\A[1-9]|[1-9][0-9]\z/}
  validates :birth_day, presence: true, format: {with: /\A[1-9]|[1-9][0-9]\z/}
  # 電話番号には全て半角数値のバリデーションをかける
  validates :phone, presence: true, format: {with: /\A[0-9]+\z/}

   def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.find_by(uid: uid, provider: provider)
    if snscredential.present?
      user = User.where(id: snscredential.user_id).first
    else
      user = User.where(email: auth.info.email).first
      if user.present?
        SnsCredential.create(
          uid: uid,
          provider: provider,
          user_id: user.id
          )
      else
        user = User.create(
          nickname: auth.info.name,
          email:    auth.info.email,
          password: Devise.friendly_token[0, 20]
          )
        SnsCredential.create(
          uid: uid,
          provider: provider,
          user_id: user.id
          )
      end
    end
    return user
  end
end
