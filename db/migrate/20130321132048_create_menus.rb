class CreateMenus < ActiveRecord::Migration
  def self.up
    create_table :menus do |t|
      t.string :nombre
      t.integer :parent_id
      t.integer :posicion
      t.string :url
      t.string :tooltip
      t.string :ayuda
      t.boolean :tiene_divisor
      t.timestamps
    end
  end

  def self.down
    drop_table :menus
  end
end
