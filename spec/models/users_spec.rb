require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '正常系' do
      it 'nickname、email、password、password_confirmation、family_name、given_name、family_name_kana、given_name_kana、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '異常系' do
      it 'nicknameが空では登録できない' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it 'given_nameが空では登録できない' do
        @user.given_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name can't be blank")
      end
      it 'family_name_kanaが空では登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it 'given_name_kanaが空では登録できない' do
        @user.given_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name kana can't be blank")
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'nicknameが40文字以上では登録できない' do
        @user = FactoryBot.build(:user, nickname: Faker::Lorem.characters(number: 41))
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is too long (maximum is 40 characters)")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordは英語だけでは登録できない' do
        @user.password = 'password'
        @user.password_confirmation = 'password'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password が無効です。文字と数字の両方を含めてください")
      end
      it 'passwordは数字だけでは登録できない' do
        @user.password = '12345678'
        @user.password_confirmation = '12345678'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password が無効です。文字と数字の両方を含めてください")
      end
      it 'family_name_kanaはカタカナでないと登録できない' do
        @user.family_name_kana = 'test', 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana が無効です。全角カタカナで入力してください")
      end
      it 'given_name_kanaはカタカナでないと登録できない' do
        @user.given_name_kana = 'test', 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name kana が無効です。全角カタカナで入力してください")
      end
      it 'family_nameに半角英数が含まれている場合登録できない' do
        @user.family_name = 'test', 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end
      it 'given_nameに半角英数が含まれている場合登録できない' do
        @user.given_name = 'test', 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name is invalid")
      end
    end
  end
end
