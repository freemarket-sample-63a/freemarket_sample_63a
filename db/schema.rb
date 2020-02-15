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

ActiveRecord::Schema.define(version: 2020_02_11_120823) do

  create_table "areas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_blands_on_name"
  end

  create_table "category_children", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "category_parent_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_parent_id"], name: "index_category_children_on_category_parent_id"
    t.index ["name"], name: "index_category_children_on_name"
  end

  create_table "category_grandchildren", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "category_child_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_child_id"], name: "index_category_grandchildren_on_category_child_id"
    t.index ["name"], name: "index_category_grandchildren_on_name"
  end

  create_table "category_parents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_category_parents_on_name"
  end

  create_table "creditcards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "pay_token", null: false
    t.string "customer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_creditcards_on_user_id"
  end

  create_table "itemimages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.string "image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_itemimages_on_item_id"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "bland_id", null: false
    t.bigint "shippingway_id", null: false
    t.bigint "category_parent_id", null: false
    t.bigint "category_child_id", null: false
    t.bigint "category_grandchild_id", null: false
    t.integer "size_num", limit: 1, null: false, unsigned: true
    t.integer "condition_num", limit: 1, null: false, unsigned: true
    t.integer "shippingcharge_num", limit: 1, null: false, unsigned: true
    t.integer "daystoship_num", limit: 1, null: false, unsigned: true
    t.string "title", null: false
    t.text "description", null: false
    t.decimal "price", precision: 10, scale: 3, null: false
    t.decimal "feerate", precision: 4, scale: 3, null: false
    t.decimal "profit_price", precision: 10, scale: 3, null: false
    t.datetime "sold_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bland_id"], name: "index_items_on_bland_id"
    t.index ["category_child_id"], name: "index_items_on_category_child_id"
    t.index ["category_grandchild_id"], name: "index_items_on_category_grandchild_id"
    t.index ["category_parent_id"], name: "index_items_on_category_parent_id"
    t.index ["condition_num"], name: "index_items_on_condition_num"
    t.index ["daystoship_num"], name: "index_items_on_daystoship_num"
    t.index ["shippingcharge_num"], name: "index_items_on_shippingcharge_num"
    t.index ["shippingway_id"], name: "index_items_on_shippingway_id"
    t.index ["size_num"], name: "index_items_on_size_num"
    t.index ["title"], name: "index_items_on_title"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "shippings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "area_id", null: false
    t.bigint "shippingway_id", null: false
    t.integer "status_num", limit: 1, null: false, unsigned: true
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "first_name_kana", null: false
    t.string "last_name_kana", null: false
    t.string "postal_number", null: false
    t.string "address_city", null: false
    t.string "address_number", null: false
    t.string "address_building", null: false
    t.string "telephone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_shippings_on_area_id"
    t.index ["shippingway_id"], name: "index_shippings_on_shippingway_id"
    t.index ["user_id"], name: "index_shippings_on_user_id"
  end

  create_table "shippingways", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "status_num", limit: 1, null: false, unsigned: true
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trades", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "user_id", null: false
    t.integer "status_num", limit: 1, null: false, unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "postal_number"
    t.bigint "area_id", null: false
    t.string "address_city"
    t.string "address_number"
    t.string "address_building"
    t.string "telephone_number"
    t.string "self_image"
    t.text "self_introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_users_on_area_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "category_children", "category_parents"
  add_foreign_key "category_grandchildren", "category_children"
  add_foreign_key "creditcards", "users"
  add_foreign_key "itemimages", "items"
  add_foreign_key "items", "blands"
  add_foreign_key "items", "category_children"
  add_foreign_key "items", "category_grandchildren"
  add_foreign_key "items", "category_parents"
  add_foreign_key "items", "shippingways"
  add_foreign_key "items", "users"
  add_foreign_key "shippings", "areas"
  add_foreign_key "shippings", "shippingways"
  add_foreign_key "shippings", "users"
  add_foreign_key "trades", "items"
  add_foreign_key "trades", "users"
  add_foreign_key "users", "areas"
end
