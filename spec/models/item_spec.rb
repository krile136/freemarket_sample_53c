require 'rails_helper'

describe Item do
  describe '#create' do
    # nameが空の時登録できないこと
    it "is invalid without a name" do
      item = build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    # descriptionが空の時登録できないこと
    it "is invalid without a description" do
      item = build(:item, description: "")
      item.valid?
      expect(item.errors[:description]).to include("can't be blank")
    end

    # priceが空の時登録できないこと
    it "is invalid without a price" do
      item = build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("can't be blank")
    end

    # name40文字以上であれば登録できないこと
    it "is invalid with a name that has more than 40 characters " do
      item = build(:item, name: "12345678911234567891123456789011234567891")
      item.valid?
      expect(item.errors[:name][0]).to include("is too long")
    end

    # name40文字以下であれば登録できること
    it "is valid with a name that has less than 40 characters " do
      item = build(:item, name: "1234567890123456789012345678901234567890")
      expect(item).to be_valid
    end
    
    #  condition_idが空の時登録できないこと
    it "is invalid without a condition_id" do
      item = build(:item, condition_id: "")
      item.valid?
      expect(item.errors[:condition_id]).to include("can't be blank")
    end

    #  postage_burden_idが空の時登録できないこと
    it "is invalid without a postage_burden_id" do
      item = build(:item, postage_burden_id: "")
      item.valid?
      expect(item.errors[:postage_burden_id]).to include("can't be blank")
    end

    #  delivery_method_idが空の時登録できないこと
    it "is invalid without a delivery_method_id" do
      item = build(:item, delivery_method_id: "")
      item.valid?
      expect(item.errors[:delivery_method_id]).to include("can't be blank")
    end

    #  category_idが空の時登録できないこと
    it "is invalid without a category_id" do
      item = build(:item, category_id: "")
      item.valid?
      expect(item.errors[:category_id]).to include("can't be blank")
    end

    #  prefecture_idが空の時登録できないこと
    it "is invalid without a prefecture_id" do
      item = build(:item, prefecture_id: "")
      item.valid?
      expect(item.errors[:prefecture_id]).to include("can't be blank")
    end

    #  delivery_day_idが空の時登録できないこと
    it "is invalid without a delivery_day_id" do
      item = build(:item, delivery_day_id: "")
      item.valid?
      expect(item.errors[:delivery_day_id]).to include("can't be blank")
    end

    #  parent_idが空の時登録できないこと
    it "is invalid without a parent_id" do
      item = build(:item, parent_id: "")
      item.valid?
      expect(item.errors[:parent_id]).to include("can't be blank")
    end

    #  child_idが空の時登録できないこと
    it "is invalid without a child_id" do
      item = build(:item, child_id: "")
      item.valid?
      expect(item.errors[:child_id]).to include("can't be blank")
    end

    #  price数字出ないと登録できないこと
    it "is invalid with a price not number " do
      item = build(:item, price: "aiueo")
      item.valid?
      expect(item.errors[:price][0]).to include("is not a number")
    end

  end
end