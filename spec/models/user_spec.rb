require 'rails_helper'

describe User do
  describe '#create' do
    # 全てのカラムに必要な情報が入っている時、登録できるか
    it "is valid with all columns" do
     user = build(:user)
     expect(user).to be_valid
    end

    # nicknameが空の時登録できないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    # emailが空の時登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    # passwordが空の時登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    # passwordが存在しても、password_confirmationがからでは登録できないこと
    it "is invalid without a password_confirmation" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    # passwordが6文字以上であれば登録できること
    it "is valid with a password that has more than 7 characters " do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user).to be_valid
    end

    # passwordが6文字以下であれば登録できないこと
    it "is invalid with a password that has less than 5 characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
    end

    # passwordが6文字以下であれば登録できないこと
    it "is invalid with a password_confirmation does not match password " do
      user = build(:user, password: "1234567", password_confirmation: "12345678")
      user.valid?
      expect(user.errors[:password_confirmation][0]).to include("doesn't match Password")
    end
    

    # メールアドレスが重複する場合保存できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    # last_nameが空の時登録できないこと
    it "is invalid without a last_name" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    # last_nameが全角ひらがなもしくは漢字でないと登録できないこと
    it "is invalid if last_name is not a full_witdh hiragana or kanji" do
      user = build(:user, last_name: "suzuki")
      user.valid?
      expect(user.errors[:last_name]).to include("is invalid")
    end

    # first_nameが空の時登録できないこと
    it "is invalid without a first_name" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    # first_nameが全角ひらがなもしくは漢字でないと登録できないこと
    it "is invalid if first_name is not a full_witdh hiragana or kanji" do
      user = build(:user, first_name: "takeshi")
      user.valid?
      expect(user.errors[:first_name]).to include("is invalid")
    end

    # last_name_kanaが空の時登録できないこと
    it "is invalid without a last_name_kana" do
      user = build(:user, last_name_kana: "")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("can't be blank")
    end

    # last_name_kanaが全角カタカナでないと登録できないこと
    it "is invalid if last_name_kana is not a full_witdh katakana" do
      user = build(:user, last_name_kana: "すずき")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("is invalid")
    end

    # first_name_kanaが空の時登録できないこと
    it "is invalid without a first_name_kana" do
      user = build(:user, first_name_kana: "")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    # first_name_kanaが全角カタカナでないと登録できないこと
    it "is invalid if first_name_kana is not a full_witdh katakana" do
      user = build(:user, first_name_kana: "すずき")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("is invalid")
    end

    # birth_yearが空の時登録できないこと
    it "is invalid without a birth_year" do
      user = build(:user, birth_year: "")
      user.valid?
      expect(user.errors[:birth_year]).to include("can't be blank")
    end

    # birth_yearが半角数字でないと登録できないこと
    it "is invalid if birth_year is not a half_witdh numbers" do
      user = build(:user, birth_year: "--")
      user.valid?
      expect(user.errors[:birth_year]).to include("is invalid")
    end

    # birth_monthが空の時登録できないこと
    it "is invalid without a birth_month" do
      user = build(:user, birth_month: "")
      user.valid?
      expect(user.errors[:birth_month]).to include("can't be blank")
    end

    # birth_monthが半角数字でないと登録できないこと
    it "is invalid if birth_month is not a half_witdh numbers" do
      user = build(:user, birth_month: "--")
      user.valid?
      expect(user.errors[:birth_month]).to include("is invalid")
    end

    # birth_dayが空の時登録できないこと
    it "is invalid without a birth_day" do
      user = build(:user, birth_day: "")
      user.valid?
      expect(user.errors[:birth_day]).to include("can't be blank")
    end

    # birth_dayが半角数字でないと登録できないこと
    it "is invalid if birth_day is not a half_witdh numbers" do
      user = build(:user, birth_day: "--")
      user.valid?
      expect(user.errors[:birth_day]).to include("is invalid")
    end

    # phoneが空の時登録できないこと
    it "is invalid without a phone" do
      user = build(:user, phone: "")
      user.valid?
      expect(user.errors[:phone]).to include("can't be blank")
    end

    # birth_yearが半角数字でないと登録できないこと
    it "is invalid if phone is not a half_witdh numbers" do
      user = build(:user, phone: "０９０１２３４５６７８")
      user.valid?
      expect(user.errors[:phone]).to include("is invalid")
    end
  end
end
