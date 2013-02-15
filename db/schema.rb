# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130214163403) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "role"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "tel"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "bills", :force => true do |t|
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
  end

  create_table "borrows", :force => true do |t|
    t.integer "material_id"
    t.integer "rental_id"
    t.integer "lesson_id"
    t.integer "quantity"
  end

  add_index "borrows", ["lesson_id"], :name => "index_borrows_on_lesson_id"
  add_index "borrows", ["material_id"], :name => "index_borrows_on_material_id"
  add_index "borrows", ["rental_id"], :name => "index_borrows_on_rent_id"

  create_table "brands", :force => true do |t|
    t.string "name"
    t.text   "description"
    t.string "website"
  end

  create_table "categories", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "categories_products", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  create_table "categories_second_hand_products", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "second_hand_product_id"
  end

  create_table "contracts", :force => true do |t|
    t.string   "contract_type"
    t.integer  "hours"
    t.integer  "done_hours"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "total_price"
    t.integer  "paid"
    t.string   "payment_method"
    t.text     "comment"
  end

  add_index "contracts", ["user_id"], :name => "index_contracts_on_user_id"

  create_table "contracts_lessons", :id => false, :force => true do |t|
    t.integer "contract_id"
    t.integer "lesson_id"
  end

  create_table "disponibilities", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "disponibilities", ["user_id"], :name => "index_disponibilities_on_user_id"

  create_table "distributors", :force => true do |t|
    t.string "name"
    t.text   "description"
    t.string "tel"
    t.string "email"
    t.text   "address"
  end

  create_table "lessons", :force => true do |t|
    t.integer  "instructor_id"
    t.integer  "hours"
    t.datetime "date"
    t.string   "lesson_type"
    t.text     "comment"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "lessons", ["instructor_id"], :name => "index_lessons_on_instructor_id"

  create_table "materials", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "quantity"
    t.string   "color"
    t.string   "size"
    t.string   "year"
    t.integer  "brand_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "materials", ["brand_id"], :name => "index_materials_on_brand_id"
  add_index "materials", ["category_id"], :name => "index_materials_on_category_id"

  create_table "pictures", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "product_id"
  end

  add_index "pictures", ["product_id"], :name => "index_pictures_on_product_id"

  create_table "products", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "quantity"
    t.string  "color"
    t.string  "size"
    t.integer "year"
    t.decimal "cost_price"
    t.decimal "selling_price"
    t.integer "brand_id"
    t.integer "distributor_id"
  end

  add_index "products", ["brand_id"], :name => "index_products_on_brand_id"
  add_index "products", ["distributor_id"], :name => "index_products_on_distributor_id"

  create_table "purchases", :force => true do |t|
    t.text     "comment"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rentals", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "price"
    t.integer  "deposit"
    t.string   "document_left"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "state"
  end

  add_index "rentals", ["user_id"], :name => "index_rents_on_user_id"

  create_table "second_hand_products", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.string  "color"
    t.string  "size"
    t.integer "year"
    t.decimal "owner_price"
    t.decimal "commission"
    t.string  "state"
    t.integer "brand_id"
    t.integer "user_id"
  end

  add_index "second_hand_products", ["brand_id"], :name => "index_second_hand_products_on_brand_id"
  add_index "second_hand_products", ["user_id"], :name => "index_second_hand_products_on_user_id"

  create_table "transactions", :force => true do |t|
    t.integer  "product_id"
    t.decimal  "total_price"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bill_id"
    t.integer  "purchase_id"
    t.string   "action"
    t.integer  "second_hand_product_id"
    t.integer  "rental_id"
    t.integer  "contract_id"
  end

  add_index "transactions", ["bill_id"], :name => "index_transactions_on_bill_id"
  add_index "transactions", ["product_id"], :name => "index_transactions_on_product_id"
  add_index "transactions", ["purchase_id"], :name => "index_transactions_on_purchase_id"
  add_index "transactions", ["second_hand_product_id"], :name => "index_transactions_on_second_hand_product_id"

  create_table "users", :force => true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "comment"
    t.string  "tel"
    t.string  "email"
    t.text    "address"
    t.string  "role"
    t.string  "language"
    t.string  "nationality"
    t.text    "level"
    t.string  "size"
    t.boolean "accept_conditions"
  end

end
