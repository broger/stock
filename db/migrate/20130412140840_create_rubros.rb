class CreateRubros < ActiveRecord::Migration
  def self.up
    create_table :rubros do |t|
         t.column  :nombre, "character(30)"
         t.integet :rubro_id
      t.timestamps
    end
  end

  def self.down
    drop_table :rubros
  end
end
