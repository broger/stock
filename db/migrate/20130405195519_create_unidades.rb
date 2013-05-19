class CreateUnidades < ActiveRecord::Migration
  def self.up
    create_table :unidades do |t|
      t.column :nombre, "character(30)"
      t.string :abreviatura

      t.timestamps
    end
  end

  def self.down
    drop_table :unidades
  end
end
