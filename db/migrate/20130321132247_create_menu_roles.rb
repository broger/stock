class CreateMenusRoles < ActiveRecord::Migration
  def self.up
    create_table :menus_roles do |t|
      t.integer :menu_id
      t.integer :rol_id

      t.timestamps
    end
  end

  def self.down
    drop_table :menu_roles
  end
end
