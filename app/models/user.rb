class User < ApplicationRecord
  has_many :creditcards
  accepts_nested_attributes_for :creditcards

  has_one :delivery_address, dependent: :destroy
  accepts_nested_attributes_for :delivery_address

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :birth_year, presence: true
  validates :birth_month, presence: true
  validates :birth_day, presence: true
end
