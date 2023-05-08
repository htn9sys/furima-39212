class OrderAddress
  extend ActiveHash::Associations::ActiveRecordExtensions

  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :post_code, :prefecture_id, :municipality, :address, :building, :phone_number

  validates :token,         presence: true
  validates :post_code,     presence: true, format: { with: /\A\d{3}[-]\d{4}\z/, message:"is invalid. Enter it as follows (e.g. 123-4567)"}
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: "is invalid" }
  validates :municipality,  presence: true
  validates :address,       presence: true
  validates :phone_number,  presence: true, format: { with: /\A\d{10,11}\z/, message: "is invalid. Input only number" }, length: { minimum: 10, message: "is too short" }
  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, address: address, building: building, phone_number: phone_number, order_id: order.id)
  end
end