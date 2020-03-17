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

ActiveRecord::Schema.define(version: 2020_03_03_102404) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "area_id", null: false
    t.integer "status_num", limit: 1, default: 0, null: false, unsigned: true
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "first_name_kana", null: false
    t.string "last_name_kana", null: false
    t.string "postal_number", null: false
    t.string "city", null: false
    t.string "number", null: false
    t.string "building"
    t.string "telephone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_addresses_on_area_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "areas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_brands_on_name"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "category_sizes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "product_size_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_sizes_on_category_id"
    t.index ["product_size_id"], name: "index_category_sizes_on_product_size_id"
  end

  create_table "creditcards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "card_id", null: false
    t.string "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_creditcards_on_user_id"
  end

  create_table "item_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.string "image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_images_on_item_id"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "address_id", null: false
    t.bigint "brand_id"
    t.bigint "category_id", null: false
    t.bigint "product_size_id"
    t.bigint "shippingway_id"
    t.integer "condition_num", limit: 1, default: 0, null: false, unsigned: true
    t.integer "daystoship_num", limit: 1, default: 0, null: false, unsigned: true
    t.string "title", null: false
    t.text "description", null: false
    t.decimal "price", precision: 10, scale: 3, null: false
    t.decimal "feerate", precision: 4, scale: 3, null: false
    t.decimal "profit_price", precision: 10, scale: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_items_on_address_id"
    t.index ["brand_id"], name: "index_items_on_brand_id"
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["condition_num"], name: "index_items_on_condition_num"
    t.index ["daystoship_num"], name: "index_items_on_daystoship_num"
    t.index ["product_size_id"], name: "index_items_on_product_size_id"
    t.index ["shippingway_id"], name: "index_items_on_shippingway_id"
    t.index ["title"], name: "index_items_on_title"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "product_sizes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_product_sizes_on_ancestry"
    t.index ["name"], name: "index_product_sizes_on_name"
  end

  create_table "shippingways", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_shippingways_on_ancestry"
    t.index ["name"], name: "index_shippingways_on_name"
  end

  create_table "trades", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "user_id", null: false
    t.bigint "address_id", null: false
    t.integer "status_num", limit: 1, default: 0, null: false, unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_trades_on_address_id"
    t.index ["item_id"], name: "index_trades_on_item_id"
    t.index ["user_id"], name: "index_trades_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "first_name_kana", null: false
    t.string "last_name_kana", null: false
    t.date "birthday", null: false
    t.string "telephone_number"
    t.string "self_image"
    t.text "self_introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "areas"
  add_foreign_key "addresses", "users"
  add_foreign_key "category_sizes", "categories"
  add_foreign_key "category_sizes", "product_sizes"
  add_foreign_key "creditcards", "users"
  add_foreign_key "item_images", "items"
  add_foreign_key "items", "addresses"
  add_foreign_key "items", "brands"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "product_sizes"
  add_foreign_key "items", "shippingways"
  add_foreign_key "items", "users"
  add_foreign_key "trades", "addresses"
  add_foreign_key "trades", "items"
  add_foreign_key "trades", "users"
end
