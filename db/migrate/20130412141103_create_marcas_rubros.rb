class CreateMarcasRubros < ActiveRecord::Migration
  def self.up
    create_table :marcas_rubros do |t|
      t.integer :marca_id
      t.integer :rubro_id

      t.timestamps
    end
  end

  def self.down
    drop_table :marcas_rubros
  end
end
