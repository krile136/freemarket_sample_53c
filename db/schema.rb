# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_07_134041) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "prefecture_id"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
  end

  create_table "creditcards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "credit_number", null: false
    t.integer "limit_month", null: false
    t.integer "limit_year", null: false
    t.integer "security_number", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_creditcards_on_user_id"
  end

  create_table "delivery_addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "delivery_last_name", null: false
    t.string "delivery_first_name", null: false
    t.string "delivery_last_name_kana", null: false
    t.string "delivery_first_name_kana", null: false
    t.string "delivery_postal_code", null: false
    t.string "delivery_city", null: false
    t.string "delivery_address", null: false
    t.string "delivery_building"
    t.string "delivery_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prefecture_id", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_delivery_addresses_on_user_id"
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_images_on_item_id"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.text "description"
    t.integer "size_id"
    t.integer "condition_id", null: false
    t.integer "category_id", null: false
    t.integer "brand_id"
    t.integer "delivery_day_id", null: false
    t.integer "delivery_method_id", null: false
    t.integer "prefecture_id", null: false
    t.integer "seller_id", null: false
    t.integer "buyer_id"
    t.integer "postage_burden_id", null: false
    t.integer "parent_id", null: false
    t.integer "child_id", null: false
    t.string "brand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "good"
    t.index ["buyer_id"], name: "index_items_on_buyer_id"
    t.index ["child_id"], name: "index_items_on_child_id"
    t.index ["parent_id"], name: "index_items_on_parent_id"
    t.index ["seller_id"], name: "index_items_on_seller_id"
  end

  create_table "sns_credentials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "uid"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname", null: false
    t.string "phone"
    t.string "profile"
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "last_name_kana", null: false
    t.string "first_name_kana", null: false
    t.integer "birth_year", null: false
    t.integer "birth_month", null: false
    t.integer "birth_day", null: false
    t.string "icon"
    t.boolean "active"
    t.integer "receivable"
    t.integer "good"
    t.integer "fair"
    t.integer "bad"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "creditcards", "users"
  add_foreign_key "delivery_addresses", "users"
  add_foreign_key "images", "items"
end
