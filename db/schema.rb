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

ActiveRecord::Schema.define(version: 20170503072426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blog_posts", force: :cascade do |t|
    t.string   "title",                          null: false
    t.string   "summary",                        null: false
    t.text     "content",                        null: false
    t.integer  "user_id",                        null: false
    t.string   "title_image_url"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "commentable",     default: true
    t.index ["user_id"], name: "index_blog_posts_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "blog_post_id"
    t.string   "name",         null: false
    t.string   "message",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["blog_post_id"], name: "index_comments_on_blog_post_id", using: :btree
  end

  create_table "pokedexes", force: :cascade do |t|
    t.string   "name",              null: false
    t.integer  "base_health_point", null: false
    t.integer  "base_attack",       null: false
    t.integer  "base_defence",      null: false
    t.integer  "base_speed",        null: false
    t.string   "element_type",      null: false
    t.string   "image_url",         null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "tag_blogs", force: :cascade do |t|
    t.integer  "blog_post_id", null: false
    t.integer  "tag_id",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["blog_post_id"], name: "index_tag_blogs_on_blog_post_id", using: :btree
    t.index ["tag_id"], name: "index_tag_blogs_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "tag_name",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                            null: false
    t.string   "email",                           null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest",                 null: false
    t.boolean  "is_admin",        default: false
  end

  add_foreign_key "blog_posts", "users"
  add_foreign_key "comments", "blog_posts", on_delete: :cascade
  add_foreign_key "tag_blogs", "blog_posts", on_delete: :cascade
  add_foreign_key "tag_blogs", "tags", on_delete: :cascade
end
