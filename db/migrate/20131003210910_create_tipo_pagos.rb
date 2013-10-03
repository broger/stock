class CreateTipoPagos < ActiveRecord::Migration
  def self.up
    create_table :tipo_pagos do |t|
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :tipo_pagos
  end
end
