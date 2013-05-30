class CreateMonedas < ActiveRecord::Migration
  def self.up
    create_table :monedas do |t|
      t.column :nombre, "character(25)"
      t.column :simbolo, "character(10)"
      
      t.timestamps
    end
  end

  def self.down
    drop_table :monedas
  end
end
