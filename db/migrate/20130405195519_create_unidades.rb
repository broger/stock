class CreateUnidades < ActiveRecord::Migration
  def self.up
    create_table :unidades do |t|
      t.column  :nombre, "character(30)"
      t.string  :abreviatura
      t.integer :orden, "character(30)"
     

      t.timestamps
    end
  end

  def self.down
    drop_table :unidades
  end
end
