require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end


  describe '商品の出品' do
    context '正常系' do
      it 'image、name、explanation、category_id、condition_id、condition_id、prefecture_id、sender_id、priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '異常系' do
      it 'ユーザーが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end

      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'category_idの選択肢が1では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category is invalid")
      end

      it 'condition_idの選択肢が1では登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition is invalid")
      end

      it 'postage_idの選択肢が1では登録できない' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage is invalid")
      end

      it 'prefecture_idの選択肢が1では登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture is invalid")
      end

      it 'sender_idの選択肢が1では登録できない' do
        @item.sender_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Sender is invalid")
      end

      it 'priceが300以下では登録できない' do
        @item.price = rand(300)
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it 'priceが9999999以上では登録できない' do
        @item.price = rand(9999999..11000000)
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end

      it 'priceが半角数字以外では登録できない' do
        @item.price = 'abc','４５６'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
      end
    end
  end
end