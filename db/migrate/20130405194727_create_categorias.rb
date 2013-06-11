class CreateCategorias < ActiveRecord::Migration
  def self.up
    create_table :categorias do |t|
      t.column :nombre, "character(30)"
      t.integer :seccion_id
      t.integer :rubro_id
      t.timestamps
    end
  end

  def self.down
    drop_table :categorias
  end
end
