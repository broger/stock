class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :nombre
      t.boolean :activo
      t.boolean :administrador
      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
