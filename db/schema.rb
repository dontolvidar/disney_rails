# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_03_134701) do
  create_table "generos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "imagen"
    t.string "nombre"
    t.datetime "updated_at", null: false
  end

  create_table "pelicula_generos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "genero_id", null: false
    t.integer "pelicula_id", null: false
    t.datetime "updated_at", null: false
    t.index ["genero_id"], name: "index_pelicula_generos_on_genero_id"
    t.index ["pelicula_id"], name: "index_pelicula_generos_on_pelicula_id"
  end

  create_table "peliculas", force: :cascade do |t|
    t.integer "calificacion"
    t.datetime "created_at", null: false
    t.integer "edad"
    t.date "fecha_calificacion"
    t.string "imagen"
    t.string "titulo"
    t.datetime "updated_at", null: false
  end

  create_table "personajes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "edad"
    t.text "historia"
    t.string "imagen"
    t.string "nombre"
    t.float "peso"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "pelicula_generos", "generos"
  add_foreign_key "pelicula_generos", "peliculas"
end
