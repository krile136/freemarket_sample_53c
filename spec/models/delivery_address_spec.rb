require 'rails_helper'

# DeliveryAddressモデルはUserモデルと同時に保存される
# Userモデルが保存される状況において、DeliveryAddressを紐づけて
# DeliveryAddressに様々パターンを試してUserモデルが保存できるかを
# テストすることでDeliveryAddressモデルのテストを行う

describe DeliveryAddress do
  describe '#create' do
    # 事前にUserモデルを作成しDeliveryAddressモデルと紐づける
    before do
      @user = build(:user)
      @user.build_delivery_address
    end

    # 全てのカラムに必要な情報が入っている時、登録できるか
    it "is valid with all columns" do
      @user.delivery_address = build(:delivery_address)
      expect(@user).to be_valid
    end

    # delivery_last_nameが空の時登録できないこと
    it "is invalid without a delivery_last_name" do
      @user.delivery_address = build(:delivery_address, delivery_last_name: "")
      @user.valid?
      expect(@user.errors[:"delivery_address.delivery_last_name"]).to include("can't be blank", "is invalid")
    end

    # delivery_last_nameが全角ひらがなもしくは漢字でないと登録できないこと
    it "is invalid if delivery_last_name is not a full_witdh hiragana or kanji" do
      @user.delivery_address = build(:delivery_address, delivery_last_name: "katou")
      @user.valid?
      expect(@user.errors[:"delivery_address.delivery_last_name"]).to include("is invalid")
    end

    # delivery_first_nameが空の時登録できないこと
    it "is invalid without a delivery_first_name" do
      @user.delivery_address = build(:delivery_address, delivery_first_name: "")
      @user.valid?
      expect(@user.errors[:"delivery_address.delivery_first_name"]).to include("can't be blank", "is invalid")
    end

    # delivery_first_nameが全角ひらがなもしくは漢字でないと登録できないこと
    it "is invalid if delivery_first_name is not a full_witdh hiragana or kanji" do
      @user.delivery_address = build(:delivery_address, delivery_first_name: "sadao")
      @user.valid?
      expect(@user.errors[:"delivery_address.delivery_first_name"]).to include("is invalid")
    end

    # delivery_last_name_kanaが空の時登録できないこと
    it "is invalid without a delivery_last_name_kana" do
      @user.delivery_address = build(:delivery_address, delivery_last_name_kana: "")
      @user.valid?
      expect(@user.errors[:"delivery_address.delivery_last_name_kana"]).to include("can't be blank", "is invalid")
    end

    # delivery_last_name_kanaが全角カタカナでないと登録できないこと
    it "is invalid if delivery_last_name is not a full_witdh katakana" do
      @user.delivery_address = build(:delivery_address, delivery_last_name_kana: "かとう")
      @user.valid?
      expect(@user.errors[:"delivery_address.delivery_last_name_kana"]).to include("is invalid")
    end

    # delivery_first_name_kanaが空の時登録できないこと
    it "is invalid without a delivery_first_name_kana" do
      @user.delivery_address = build(:delivery_address, delivery_first_name_kana: "")
      @user.valid?
      expect(@user.errors[:"delivery_address.delivery_first_name_kana"]).to include("can't be blank", "is invalid")
    end

    # delivery_first_name_kanaが全角カタカナでないと登録できないこと
    it "is invalid if delivery_first_name is not a full_witdh katakana" do
      @user.delivery_address = build(:delivery_address, delivery_first_name_kana: "かとう")
      @user.valid?
      expect(@user.errors[:"delivery_address.delivery_first_name_kana"]).to include("is invalid")
    end

    # delivery_postal_codeが空の時登録できないこと
    it "is invalid without a delivery_postal_code" do
      @user.delivery_address = build(:delivery_address, delivery_postal_code: "")
      @user.valid?
      expect(@user.errors[:"delivery_address.delivery_postal_code"]).to include("can't be blank", "is invalid")
    end

    # delivery_postal_codeがxxx-xxxxの形式でないと登録できないこと
    it "is invalid if delivery_postal_code is not a type 'xxx-xxxx' " do
      @user.delivery_address = build(:delivery_address, delivery_postal_code: "1234567")
      @user.valid?
      expect(@user.errors[:"delivery_address.delivery_postal_code"]).to include("is invalid")
    end

    # prefecture_idが空の時登録できないこと
    it "is invalid without a prefecture_id" do
      @user.delivery_address = build(:delivery_address, prefecture_id: "")
      @user.valid?
      expect(@user.errors[:"delivery_address.prefecture_id"]).to include("can't be blank")
    end

    # delivery_cityが空の時登録できないこと
    it "is invalid without a delivery_city" do
      @user.delivery_address = build(:delivery_address, delivery_city: "")
      @user.valid?
      expect(@user.errors[:"delivery_address.delivery_city"]).to include("can't be blank")
    end

    # delivery_addressが空の時登録できないこと
    it "is invalid without a delivery_city" do
      @user.delivery_address = build(:delivery_address, delivery_address: "")
      @user.valid?
      expect(@user.errors[:"delivery_address.delivery_address"]).to include("can't be blank")
    end
  end
end
