require 'rails_helper'

# creditcardモデルはUserモデルと同時に保存される
# Userモデルが保存される状況において、Creditcardを紐づけて
# Creditcardに様々パターンを試してUserモデルが保存できるかを
# テストすることでCreditcardモデルのテストを行う

describe Creditcard do
  describe '#create' do
    # 事前にUserモデルを作成しDeliveryAddressモデルと紐づける
    before do
      @user = build(:user)
      @user.creditcards.build
    end

    # 全てのカラムに必要な情報が入っている時、登録できるか
    it "is valid with all columns" do
      @user.creditcards = build_list(:creditcard,1)
      expect(@user).to be_valid
    end

    # credit_numberが空の時登録できないこと
    it "is invalid without a credit_number" do
      @user.creditcards = build_list(:creditcard, 1, credit_number: "")
      @user.valid?
      expect(@user.errors[:"creditcards.credit_number"]).to include("を入力してください", "は不正な値です")
    end

    # credit_numberが適当な文字列だと登録できないこと
    it "is invalid if credit_number is not a correct credit card numbers" do
      @user.creditcards = build_list(:creditcard, 1, credit_number: "1234567812345678")
      @user.valid?
      expect(@user.errors[:"creditcards.credit_number"]).to include("は不正な値です")
    end

    # limit_monthが空の時登録できないこと
    it "is invalid without a limit_month" do
      @user.creditcards = build_list(:creditcard, 1, limit_month: "")
      @user.valid?
      expect(@user.errors[:"creditcards.limit_month"]).to include("を入力してください", "は不正な値です")
    end

    # limit_monthが半角数字出ないと登録できないこと
    it "is invalid if limit_year is not a half_witdh numbers" do
      @user.creditcards = build_list(:creditcard, 1, limit_month: "--")
      @user.valid?
      expect(@user.errors[:"creditcards.limit_month"]).to include("は不正な値です")
    end

    # limit_yearが空の時登録できないこと
    it "is invalid without a limit_year" do
      @user.creditcards = build_list(:creditcard, 1, limit_year: "")
      @user.valid?
      expect(@user.errors[:"creditcards.limit_year"]).to include("を入力してください", "は不正な値です")
    end

    # limit_yearが半角数字出ないと登録できないこと
    it "is invalid if limit_year is not a half_witdh numbers" do
      @user.creditcards = build_list(:creditcard, 1, limit_year: "--")
      @user.valid?
      expect(@user.errors[:"creditcards.limit_year"]).to include("は不正な値です")
    end

    # security_numberが空の時登録できないこと
    it "is invalid without a security_number" do
      @user.creditcards = build_list(:creditcard, 1, security_number: "")
      @user.valid?
      expect(@user.errors[:"creditcards.security_number"]).to include("を入力してください", "は不正な値です")
    end

    # security_numberが半角数字3文字であれば登録できること
    it "is valid if security_number is three numbers" do
      @user.creditcards = build_list(:creditcard, 1, security_number: "999")
      expect(@user).to be_valid
    end

    # security_numberが半角数字4文字であれば登録できること
    it "is valid if security_number is four numbers" do
      @user.creditcards = build_list(:creditcard, 1, security_number: "9999")
      expect(@user).to be_valid
    end

    # security_numberが半角数字5文字以上であれば登録できないこと
    it "is invalid if security_number is over five numbers" do
      @user.creditcards = build_list(:creditcard, 1, security_number: "99999")
      @user.valid?
      expect(@user.errors[:"creditcards.security_number"]).to include("は不正な値です")
    end

    # security_numberが半角数字2文字以下であれば登録できないこと
    it "is invalid if security_number is under two numbers" do
      @user.creditcards = build_list(:creditcard, 1, security_number: "99")
      @user.valid?
      expect(@user.errors[:"creditcards.security_number"]).to include("は不正な値です")
    end
  end
end
