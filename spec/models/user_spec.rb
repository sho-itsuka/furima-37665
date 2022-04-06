require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、last_nameとfirst_name、last_name_kanaとfirst_name_kana、birth_dateが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき'
    it 'ニックネームが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors[:nickname]).to include('を入力してください')
    end
    it 'メールアドレスが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors[:email]).to include('を入力してください')
    end
    it 'メールアドレスが一意性でないと登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include('はすでに存在します')
    end
    it 'メールアドレスは、@を含まないと登録できない' do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors[:email]).to include('は不正な値です')
    end
    it 'パスワードが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors[:password]).to include('を入力してください', 'には6文字以上かつ英字と数字の両方を含めて設定してください')
    end
    it 'パスワードは、5文字以下では登録できない' do
      @user.password = 'aaa11'
      @user.password_confirmation = 'aaa11'
      @user.valid?
      expect(@user.errors[:password]).to include('は6文字以上で入力してください')
    end
    it 'パスワードは、半角英数字混合での入力でないと登録できない' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'aaaaaa'
      @user.valid?
      expect(@user.errors[:password]).to include('には6文字以上かつ英字と数字の両方を含めて設定してください')
    end
    it 'パスワードとパスワード（確認）は、値が一致しないと登録できない' do
      @user.password = 'aaa111'
      @user.password_confirmation = 'aaa222'
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include('とpasswordの入力が一致しません')
    end
    it 'お名前(全角)は、名字(last_name)が空では登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors[:last_name]).to include('を入力してください')
    end
    it 'お名前(全角)は、名前(first_name)が空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors[:first_name]).to include('を入力してください')
    end
    it 'お名前(全角)は、名字(last_name)が全角（漢字・ひらがな・カタカナ）の入力でないと登録できない' do
      @user.last_name = 'sato'
      @user.valid?
      expect(@user.errors[:last_name]).to include('全角文字を使用してください')
    end
    it 'お名前(全角)は、名前(first_name)が全角（漢字・ひらがな・カタカナ）の入力でないと登録できない' do
      @user.first_name = 'taro'
      @user.valid?
      expect(@user.errors[:first_name]).to include('全角文字を使用してください')
    end
    it 'お名前カナ(全角)は、名字(last_name_kana)が空では登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors[:last_name_kana]).to include('を入力してください')
    end
    it 'お名前カナ(全角)は、名前(first_name)が空では登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors[:first_name_kana]).to include('を入力してください')
    end
    it 'お名前カナ(全角)は、名字(last_name)が全角（カタカナ）の入力でないと登録できない' do
      @user.last_name_kana = 'yamada'
      @user.valid?
      expect(@user.errors[:last_name_kana]).to include('全角カタカナを使用してください')
    end
    it 'お名前カナ(全角)は、名前(first_name)が全角（カタカナ）の入力でないと登録できない' do
      @user.first_name_kana = 'jiro'
      @user.valid?
      expect(@user.errors[:first_name_kana]).to include('全角カタカナを使用してください')
    end
    it '生年月日(birth_date)が空では登録できない' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors[:birth_date]).to include('を入力してください')
    end
  end
end
