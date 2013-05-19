class CreateSecciones < ActiveRecord::Migration
  def self.up
    create_table :secciones do |t|
      t.column :nombre, "character(30)"
      t.integer :rubro_id

      t.timestamps
    end
  end

  def self.down
    drop_table :secciones
  end
end
