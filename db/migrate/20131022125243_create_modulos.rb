class CreateModulos < ActiveRecord::Migration
  def self.up
    create_table :modulos do |t|
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :modulos
  end
end
