class CreateProductoStocks < ActiveRecord::Migration
  def self.up
    create_table :producto_stocks do |t|
      t.integer :producto_id
      t.integer :deposito_id
      t.double  :stock
      

      t.timestamps
    end
  end

  def self.down
    drop_table :producto_stocks
  end
end
