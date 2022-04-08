require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の出品' do
    context '出品できるとき' do
      it '商品名、商品の価格、商品の説明、商品のカテゴリー、商品の状態、配送料の負担、発送にかかる日程、発送元の地域、商品画像があれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it '「商品名」がないと出品できない' do
        @item.title = ''
        @item.invalid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end
      it '「商品の価格」がないと出品できない' do
        @item.price = ''
        @item.invalid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '「商品の説明」がないと出品できない' do
        @item.description = ''
        @item.invalid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it '「商品のカテゴリー」が指定されていないと出品できない' do
        @item.category_id = 1
        @item.invalid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '「商品の状態」が指定されていないと出品できない' do
        @item.item_status_id = 1
        @item.invalid?
        expect(@item.errors.full_messages).to include("Item status can't be blank")
      end
      it '「配送料の負担」が指定されていないと出品できない' do
        @item.ship_cost_id = 1
        @item.invalid?
        expect(@item.errors.full_messages).to include("Ship cost can't be blank")
      end
      it '「発送までの日数」が指定されていないと出品できない' do
        @item.ship_day_id = 1
        @item.invalid?
        expect(@item.errors.full_messages).to include("Ship day can't be blank")
      end
      it '「発送元の地域」が指定されていないと出品できない' do
        @item.ship_area_id = 1
        @item.invalid?
        expect(@item.errors.full_messages).to include("Ship area can't be blank")
      end
      it '「商品画像」が指定されていないと出品できない' do
        @item.image = nil
        @item.invalid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it ' 商品の価格は¥300以上でないと出品できない' do
        @item.price = '250'
        @item.invalid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
      it ' 商品の価格は¥9,999,999以下でないと出品できない' do
        @item.price = '10,000,000'
        @item.invalid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
      it ' 商品の価格は全角数字だと保存できない' do
        @item.price = '１０００'
        @item.invalid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
    end
  end
end
