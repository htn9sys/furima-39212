class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  validates :image,         presence: true
  validates :name,          presence: true
  validates :explanation,   presence: true
  validates :category_id,   presence: true, numericality: { other_than: 1, message: "is invalid" }
  validates :condition_id,  presence: true, numericality: { other_than: 1, message: "is invalid" }
  validates :postage_id,    presence: true, numericality: { other_than: 1, message: "is invalid" }
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: "is invalid" }
  validates :sender_id,     presence: true, numericality: { other_than: 1, message: "is invalid" }
  validates :price,         presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, }
  
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :sender
  belongs_to :user
  has_one_attached :image
end

