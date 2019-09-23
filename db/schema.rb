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

ActiveRecord::Schema.define(version: 20190923164616) do

  create_table "compound_synonyms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "compounds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "public_id", null: false
    t.string "name", null: false
    t.string "smiles"
    t.string "inchi"
    t.string "inchikey", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "customized_nucleotide_sequences", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "header"
    t.text "chain"
    t.integer "uploader_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reference"
    t.integer "group"
    t.date "update_date"
    t.date "publication_date"
    t.string "tree_name"
    t.string "key_group"
    t.string "organism"
    t.string "key"
    t.string "uploader"
  end

  create_table "customized_protein_sequences", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "header"
    t.text "chain"
    t.integer "uploader_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reference"
    t.integer "group"
    t.date "update_date"
    t.date "publication_date"
    t.string "tree_name"
    t.string "key_group"
    t.string "organism"
    t.string "key"
    t.string "uploader"
  end

  create_table "nucleotide_sequences", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "header"
    t.text "chain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reference"
    t.integer "group"
    t.date "update_date"
    t.date "publication_date"
    t.string "tree_name"
    t.string "key_group"
    t.string "organism"
    t.string "key"
  end

  create_table "protein_sequences", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "header"
    t.text "chain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uploader"
    t.string "reference"
    t.integer "group"
    t.date "update_date"
    t.date "publication_date"
    t.string "tree_name"
    t.string "key_group"
    t.string "organism"
    t.string "key"
  end

  create_table "queries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.text "sequence", limit: 4294967295
    t.integer "query_range_up"
    t.integer "query_range_down"
    t.string "job_title"
    t.string "database"
    t.string "organism"
    t.string "report_format"
    t.string "algorithm"
    t.string "email"
    t.boolean "file_upload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sequence_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "generic_id"
    t.string "origin"
    t.string "reference"
    t.string "type"
    t.date "publish_date"
    t.string "organism"
    t.string "key"
    t.string "key_origin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploaders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "uploader_id", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.string "institution", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
