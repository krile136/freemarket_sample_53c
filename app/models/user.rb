class User < ApplicationRecord
  has_many :creditcards
  accepts_nested_attributes_for :creditcards

  has_one :delivery_address
  accepts_nested_attributes_for :delivery_address

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
end
