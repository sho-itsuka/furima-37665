require 'rails_helper'

RSpec.describe OrderDelivary, type: :model do
  describe '購入情報の保存' do
    before do
      item = FactoryBot.create(:item)
      user = FactoryBot.create(:user)
      @order_delivary = FactoryBot.build(:order_delivary, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_delivary).to be_valid
      end
      it 'buildingが空でも保存できること' do
        @order_delivary.building = ''
        expect(@order_delivary).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postcodeが空だと保存できないこと' do
        @order_delivary.postcode = ''
        @order_delivary.valid?
        expect(@order_delivary.errors.full_messages).to include("Postcode can't be blank")
      end
      it 'postcodeが3桁ハイフン4桁」でないと保存できないこと' do
        @order_delivary.postcode = '1234567'
        @order_delivary.valid?
        expect(@order_delivary.errors.full_messages).to include("Postcode is invalid. Enter it as follows(e.g. 123-4567)")
      end
      it '都道府県(ship_area)を選択していないと保存できないこと' do
        @order_delivary.ship_area_id = 1
        @order_delivary.valid?
        expect(@order_delivary.errors.full_messages).to include("Ship area can't be blank")
      end
      it '市区町村(city)が空だと保存できないこと' do
        @order_delivary.city = ''
        @order_delivary.valid?
        expect(@order_delivary.errors.full_messages).to include("City can't be blank")
      end
      it '番地(block)が空だと保存できないこと' do
        @order_delivary.block = ''
        @order_delivary.valid?
        expect(@order_delivary.errors.full_messages).to include("Block can't be blank")
      end
      it '電話番号(phonenumber)が空だと保存できないこと' do
        @order_delivary.phonenumber = ''
        @order_delivary.valid?
        expect(@order_delivary.errors.full_messages).to include("Phonenumber can't be blank")
      end
      it '電話番号(phonenumber)が10桁以上11桁以内でないと保存できないこと' do
        @order_delivary.phonenumber = '090111222'
        @order_delivary.valid?
        expect(@order_delivary.errors.full_messages).to include("Phonenumber is too short")
      end
      it '電話番号(phonenumber)が半角数値でないと保存できないこと' do
        @order_delivary.phonenumber = 'aaabbbbcccc'
        @order_delivary.valid?
        expect(@order_delivary.errors.full_messages).to include("Phonenumber is invalid. Input only number", "Phonenumber is too short")
      end
      it 'userが紐付いていないと保存できないこと' do
        @order_delivary.user_id = nil
        @order_delivary.invalid?
        expect(@order_delivary.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @order_delivary.item_id = nil
        @order_delivary.invalid?
        expect(@order_delivary.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end