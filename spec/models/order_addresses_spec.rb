require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品の購入' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    end

    context '正常系' do
      it 'user_id、item_id、token、post_code、prefecture_id、municipality、address、phone_numberが存在すれば購入できる' do
        expect(@order_address).to be_valid
      end

      it 'buildingは空でも購入できる' do
        @order_address.building =''
        expect(@order_address).to be_valid
      end
    end

    context '異常系' do
      it 'user_idが空だと購入できない' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと購入できない' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが空だと購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'post_codeが空だと購入できない' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank", "Post code が無効です。次のように入力してください(例: 123-4567)")
      end

      it 'prefecture_idが空だと購入できない' do
        @order_address.prefecture_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'municipalityが空だと購入できない' do
        @order_address.municipality = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Municipality can't be blank")
      end

      it 'addressが空だと購入できない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが空だと購入できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank", "Phone number が無効です。数字で入力してください", "Phone number が10文字以下です")
      end
      
      it 'post_codeは3桁(-)4桁の数字でないと購入できない' do
        @order_address.post_code = '1234-123' , '123-456a'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code が無効です。次のように入力してください(例: 123-4567)")
      end

      it 'prefecture_idが"1"では購入できない' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture が無効です")
      end

      it 'phone_numberが10桁以下では購入できない' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number が10文字以下です")
      end

      it 'phone_numberが10桁もしくは11桁の数字でないと購入できない' do
        @order_address.phone_number = '123456789a','1234567890a'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number が無効です。数字で入力してください")
      end

      it 'itemが紐づいていなければ購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
      end

      it 'ユーザーが紐付いていなければ購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
      end
    end
  end
end