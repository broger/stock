class CreateDepositos < ActiveRecord::Migration
  def self.up
    create_table :depositos do |t|
      t.column :nombre, "character(40)"

      t.timestamps
    end
  end

  def self.down
    drop_table :depositos
  end
end
