require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'すべての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合（エラーハンドリングの検証）' do
      # --- ユーザー情報に関するテスト ---
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスを入力してください')
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレスはすでに存在します')
      end

      it 'emailに@を含まない場合は登録できない' do
        @user.email = 'testtest.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは不正な値です')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = 'ab123'
        @user.password_confirmation = 'ab123'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordが英語のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end

      it 'passwordに全角文字が含まれていると登録できない' do
        @user.password = 'ａb1234' # 「ａ」が全角
        @user.password_confirmation = 'ａb1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end

      it 'passwordとpassword_confirmationが一致しない場合は登録できない' do
        @user.password_confirmation = 'xyz789'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認）とパスワードの入力が一致しません')
      end

      # --- 本人確認情報（お名前全角）に関するテスト ---
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(全角)の名字を入力してください')
      end

      it 'first_name`が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(全角)の名前を入力してください')
      end

      # --- 本人確認情報（お名前全角）の文字タイプに関するテスト ---
      it 'last_nameが半角文字では登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(全角)の名字は全角文字で入力してください')
      end

      it 'first_nameが半角文字では登録できない' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(全角)の名前は全角文字で入力してください')
      end

      # --- 本人確認情報（お名前カナ全角）に関するテスト ---
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(全角)の名字を入力してください')
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(全角)の名前を入力してください')
      end

      # --- 本人確認情報（お名前カナ全角）の文字タイプに関するテスト ---
      it 'last_name_kanaにカタカナ以外の文字（ひらがなや漢字など）が含まれると登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(全角)の名字は全角カタカナで入力してください')
      end

      it 'first_name_kanaにカタカナ以外の文字（ひらがなや漢字など）が含まれると登録できない' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(全角)の名前は全角カタカナで入力してください')
      end

      # --- 生年月日に関するテスト ---
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
    end
  end
end
