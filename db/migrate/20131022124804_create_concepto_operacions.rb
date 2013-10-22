class CreateConceptoOperacions < ActiveRecord::Migration
  def self.up
    create_table :concepto_operacions do |t|
      t.string  :nombre
      t.integer :modulo_id

      t.timestamps
    end
  end

  def self.down
    drop_table :concepto_operacions
  end
end
