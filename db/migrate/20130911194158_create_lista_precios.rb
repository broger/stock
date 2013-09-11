class CreateListaPrecios < ActiveRecord::Migration
  def self.up
    create_table :lista_precios do |t|
      t.integer :codigo
      t.column  :nombre, "character(40)"
      t.column  :abrev,  "character(16)"
      t.date :desde
      t.date :hasta

      t.timestamps
    end
  end

  def self.down
    drop_table :lista_precios
  end
end
