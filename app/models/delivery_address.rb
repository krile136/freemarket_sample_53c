class DeliveryAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user

  validates :delivery_last_name, presence: true, format: {with: /\A[一-龥ぁ-ん]+\z/}
  validates :delivery_first_name, presence: true, format: {with: /\A[一-龥ぁ-ん]+\z/}
  validates :delivery_last_name_kana, presence: true, format: {with: /\A[\u30a0-\u30ff]+\z/}
  validates :delivery_first_name_kana, presence: true, format: {with: /\A[\u30a0-\u30ff]+\z/}
  validates :delivery_postal_code, presence: true, format: {with: /\A\d{3}[-]\d{4}\z/}
  validates :prefecture_id, presence: true, format: {with: /\A[1-9]|[1-9][0-9]\z/}
  validates :delivery_city, presence: true
  validates :delivery_address, presence: true
end
