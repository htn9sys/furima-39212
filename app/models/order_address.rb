class OrderAddress
  extend ActiveHash::Associations::ActiveRecordExtensions

  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :post_code, :prefecture_id, :municipality, :address, :building, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :post_code,     format: { with: /\A\d{3}[-]\d{4}\z/, message:"が無効です。次のように入力してください(例: 123-4567)"}
    validates :prefecture_id, numericality: { other_than: 1, message: "が無効です" }
    validates :municipality
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "が無効です。数字で入力してください" }, length: { minimum: 10, message: "が10文字以下です" }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, address: address, building: building, phone_number: phone_number, order_id: order.id)
  end
end