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

ActiveRecord::Schema.define(version: 2020_02_27_212119) do

  create_table "active_admin_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", limit: 191, null: false
    t.string "record_type", limit: 191, null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "key", limit: 191, null: false
    t.string "filename", limit: 191, null: false
    t.string "content_type", limit: 191
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", limit: 191, null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_admin_users_on_unlock_token", unique: true
  end

  create_table "compound_strain_rels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "strain_header", limit: 191, null: false
    t.string "rddb_id", limit: 191, null: false
    t.string "reference", limit: 191
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "compound_id"
    t.integer "protein_id"
  end

  create_table "compound_synonyms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "compounds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "public_id", limit: 191, null: false
    t.string "name", limit: 191, null: false
    t.string "smiles", limit: 191
    t.string "inchi", limit: 191
    t.string "inchikey", limit: 191, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "cas_number", limit: 191
    t.string "formula", limit: 191
    t.string "iupac", limit: 191
    t.string "average_mass", limit: 191
    t.string "mono_mass", limit: 191
    t.string "state", limit: 191
    t.string "physical_description", limit: 191
    t.string "physical_description_reference", limit: 191
    t.string "percent_composition", limit: 191
    t.string "percent_composition_reference", limit: 191
    t.string "melting_point", limit: 191
    t.string "melting_point_reference", limit: 191
    t.string "boiling_point", limit: 191
    t.string "boiling_point_reference", limit: 191
    t.string "experimental_solubility", limit: 191
    t.string "experimental_solubility_reference", limit: 191
    t.string "experimental_logp", limit: 191
    t.string "experimental_logp_reference", limit: 191
    t.string "experimental_pka", limit: 191
    t.string "experimental_pka_reference", limit: 191
    t.string "charge", limit: 191
    t.string "charge_reference", limit: 191
    t.string "optical_rotation", limit: 191
    t.string "optical_rotation_reference", limit: 191
    t.string "uv_index", limit: 191
    t.string "uv_index_reference", limit: 191
    t.string "density", limit: 191
    t.string "density_reference", limit: 191
    t.string "refractive_index", limit: 191
    t.string "refractive_index_reference", limit: 191
    t.string "chemspider_id", limit: 191
    t.string "chembl_id", limit: 191
    t.string "kegg_compound_id", limit: 191
    t.string "pubchem_compound_id", limit: 191
    t.string "pubchem_substance_id", limit: 191
    t.string "chebi_id", limit: 191
    t.string "phenolexplorer_id", limit: 191
    t.string "drugbank_id", limit: 191
    t.string "hmdb_id", limit: 191
    t.string "dfc_id", limit: 191
    t.string "eafus_id", limit: 191
    t.string "bigg_id", limit: 191
    t.string "knapsack_id", limit: 191
    t.string "het_id", limit: 191
    t.string "wikipedia_id", limit: 191
  end

  create_table "customized_nucleotide_sequences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "header", limit: 191
    t.text "chain"
    t.integer "uploader_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reference", limit: 191
    t.integer "group"
    t.date "update_date"
    t.date "publication_date"
    t.string "tree_name", limit: 191
    t.string "key_group", limit: 191
    t.string "organism", limit: 191
    t.string "key", limit: 191
    t.string "uploader", limit: 191
    t.string "accession_no", limit: 191
    t.string "species", limit: 191
    t.string "protein_name", limit: 191
    t.string "uploader_name", limit: 191
    t.string "uploader_email", limit: 191
    t.integer "protein_id"
  end

  create_table "customized_protein_sequences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "header", limit: 191
    t.text "chain"
    t.integer "uploader_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reference", limit: 191
    t.integer "group"
    t.date "update_date"
    t.date "publication_date"
    t.string "tree_name", limit: 191
    t.string "key_group", limit: 191
    t.string "organism", limit: 191
    t.string "key", limit: 191
    t.string "uploader", limit: 191
    t.string "accession_no", limit: 191
    t.string "species", limit: 191
    t.string "protein_name", limit: 191
    t.string "uploader_name", limit: 191
    t.string "uploader_email", limit: 191
    t.integer "characterized", limit: 1
    t.integer "single", limit: 1
  end

  create_table "queries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.text "sequence", limit: 4294967295
    t.integer "query_range_up"
    t.integer "query_range_down"
    t.string "job_title", limit: 191
    t.string "database", limit: 191
    t.string "organism", limit: 191
    t.string "report_format", limit: 191
    t.string "algorithm", limit: 191
    t.string "email", limit: 191
    t.boolean "file_upload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "references", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "pubmed_id"
    t.string "citation", limit: 191
    t.string "doi", limit: 191
    t.string "url", limit: 191
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "strain_id"
  end

  create_table "sequence_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "generic_id", limit: 191
    t.string "origin", limit: 191
    t.string "reference", limit: 191
    t.string "type", limit: 191
    t.date "publish_date"
    t.string "organism", limit: 191
    t.string "key", limit: 191
    t.string "key_origin", limit: 191
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploaders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "uploader_id", limit: 191, null: false
    t.string "name", limit: 191, null: false
    t.string "email", limit: 191, null: false
    t.string "institution", limit: 191, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
