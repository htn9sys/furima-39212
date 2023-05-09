class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,         presence: true, length: { maximum: 40 }

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
    validates :family_name,    presence: true
    validates :given_name,     presence: true
  end

  validates :family_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "が無効です。全角カタカナで入力してください" }
  validates :given_name_kana,  presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "が無効です。全角カタカナで入力してください" }

  validates :birthday,         presence: true

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}\z/i, message: "が無効です。文字と数字の両方を含めてください"}

  has_many :items
  has_many :orders
end
