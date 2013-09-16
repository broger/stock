# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130913222354) do

  create_table "categorias", :force => true do |t|
    t.string   "nombre",     :limit => 30
    t.integer  "seccion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rubro_id"
  end

  create_table "clientes", :force => true do |t|
    t.string   "nombre",         :limit => 60
    t.integer  "cuil",           :limit => 12, :precision => 12, :scale => 0
    t.integer  "provincia_id"
    t.integer  "localidad_id"
    t.string   "direccion",      :limit => 80
    t.integer  "banco_id"
    t.integer  "cuenta_bacaria", :limit => 30, :precision => 30, :scale => 0
    t.integer  "telefono",       :limit => 30, :precision => 30, :scale => 0
    t.integer  "celular",        :limit => 30, :precision => 30, :scale => 0
    t.string   "email",          :limit => 60
    t.integer  "estado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comprobantes", :force => true do |t|
    t.integer  "tipo_comprobante_id"
    t.integer  "numero",              :limit => 16, :precision => 16, :scale => 0
    t.integer  "total",               :limit => 10, :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "depositos", :force => true do |t|
    t.string   "nombre",       :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "localidad_id"
    t.integer  "provincia_id"
    t.string   "direccion",    :limit => 60
    t.string   "telefono",     :limit => 30
  end

  create_table "estados", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lista_precios", :force => true do |t|
    t.string   "nombre",     :limit => 40
    t.string   "abrev",      :limit => 16
    t.date     "desde"
    t.date     "hasta"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "localidades", :force => true do |t|
    t.string   "nombre"
    t.integer  "provincia_id"
    t.integer  "codigo_postal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marcas", :force => true do |t|
    t.string   "nombre",     :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rubro_id"
  end

  create_table "marcas_rubros", :force => true do |t|
    t.integer  "marca_id"
    t.integer  "rubro_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", :force => true do |t|
    t.string   "nombre"
    t.integer  "parent_id"
    t.integer  "posicion"
    t.string   "url"
    t.string   "tooltip"
    t.string   "ayuda"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "tiene_divisor"
  end

  create_table "menus_roles", :force => true do |t|
    t.integer  "menu_id"
    t.integer  "rol_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monedas", :force => true do |t|
    t.string   "nombre",     :limit => 25
    t.string   "simbolo",    :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movimientos", :force => true do |t|
    t.integer  "producto_id"
    t.decimal  "cantidad",       :precision => 8, :scale => 4
    t.boolean  "afecta_stock"
    t.integer  "deposito_id"
    t.integer  "comprobante_id"
    t.integer  "usuario_id"
    t.string   "comentarios"
    t.decimal  "costo",          :precision => 8, :scale => 4
    t.decimal  "ganancia",       :precision => 8, :scale => 4
    t.decimal  "iva",            :precision => 8, :scale => 4
    t.decimal  "descuento",      :precision => 8, :scale => 4
    t.decimal  "precio_total",   :precision => 8, :scale => 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parametros", :force => true do |t|
    t.integer  "iva"
    t.integer  "descuento"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nombre_empresa", :limit => 100
    t.string   "direccion",      :limit => 150
    t.string   "telefono1",      :limit => 50
    t.string   "telefono2",      :limit => 50
    t.string   "celular1",       :limit => 50
    t.string   "celular2",       :limit => 50
    t.integer  "localidad_id"
    t.integer  "provincia_id"
    t.integer  "cuil",           :limit => 12,  :precision => 12, :scale => 0
  end

  create_table "producto_lista_precios", :force => true do |t|
    t.integer  "producto_id"
    t.integer  "lista_precio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "precio",          :precision => 8, :scale => 4
    t.decimal  "descuento",       :precision => 8, :scale => 2
  end

  create_table "productos", :force => true do |t|
    t.string   "nombre",            :limit => 60
    t.string   "descripcion"
    t.integer  "marca_id"
    t.integer  "unidad_id"
    t.integer  "rubro_id"
    t.integer  "seccion_id"
    t.integer  "categoria_id"
    t.integer  "codigo_proveedor"
    t.decimal  "stock_minimo",                    :precision => 8, :scale => 2
    t.boolean  "visible_web"
    t.integer  "estado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "costo",                           :precision => 8, :scale => 2
    t.decimal  "ganancia",                        :precision => 8, :scale => 2
    t.decimal  "descuento",                       :precision => 5, :scale => 2
    t.decimal  "iva",                             :precision => 8, :scale => 2
    t.integer  "proveedor_id"
    t.decimal  "stock_maximo",                    :precision => 8, :scale => 2
    t.string   "calificacion",      :limit => 1
    t.decimal  "punto_de_pedido",                 :precision => 8, :scale => 2
    t.string   "codigo",            :limit => 8
    t.string   "etiqueta_busqueda", :limit => 30
  end

  create_table "proveedores", :force => true do |t|
    t.string   "nombre",         :limit => 60
    t.string   "razon_social",   :limit => 60
    t.integer  "cuil",           :limit => 12, :precision => 12, :scale => 0
    t.integer  "provincia_id"
    t.integer  "localidad_id"
    t.string   "direccion",      :limit => 80
    t.integer  "banco_id"
    t.integer  "cuenta_bacaria", :limit => 30, :precision => 30, :scale => 0
    t.integer  "telefono1",      :limit => 30, :precision => 30, :scale => 0
    t.integer  "telefono2",      :limit => 30, :precision => 30, :scale => 0
    t.integer  "celular1",       :limit => 30, :precision => 30, :scale => 0
    t.integer  "celular2",       :limit => 30, :precision => 30, :scale => 0
    t.string   "email",          :limit => 60
    t.string   "web",            :limit => 60
    t.integer  "estado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provincias", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "nombre"
    t.boolean  "activo"
    t.boolean  "administrador"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :force => true do |t|
    t.integer  "rol_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rubros", :force => true do |t|
    t.string   "nombre",     :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "secciones", :force => true do |t|
    t.string   "nombre",     :limit => 30
    t.integer  "rubro_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipo_comprobantes", :force => true do |t|
    t.integer  "ultimo_nro",   :limit => 10, :precision => 10, :scale => 0
    t.string   "nombre"
    t.boolean  "registra_nro"
    t.boolean  "afecta_stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unidades", :force => true do |t|
    t.string   "nombre",      :limit => 30
    t.string   "abreviatura"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
