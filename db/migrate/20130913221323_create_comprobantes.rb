class CreateComprobantes < ActiveRecord::Migration
  def self.up
    create_table :comprobantes do |t|
      t.integer  :tipo_comprobante_id
      t.column   :numero, "numeric(16)"
      t.column   :total,   "numeric(10)"
      t.boolean  :aprobado
      t.integer  :proveedor_id
      t.integer  :forma_pago_id
      t.column   :nro_tarjeta
      t.integer  :usuario_id
      t.integer  :vendedor_id
      t.string   :observaciones

    end
  end

  def self.down
    drop_table :comprobantes
  end
end
