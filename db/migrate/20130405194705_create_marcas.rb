class CreateMarcas < ActiveRecord::Migration
  def self.up
    create_table :marcas do |t|
      t.column :nombre, "character(20)"
      t.timestamps
    end
  end

  def self.down
    drop_table :marcas
  end
end
